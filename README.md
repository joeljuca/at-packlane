# Packbox

## One-time setup

Please use Erlang/OTP version 23.x.x or lower to avoid Phoenix compilation issues.

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Go back to project's root directory and start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Introduction

The overall goal of this assignment is to add some specific functionality on top of the code provided in this
repository.

Imagine that you're working with codebase of a real application. When you write new code, make sure to follow best
practices, document the "why" that's not apparent in the code itself, include function specs and types if they can
improve code readability, etc.

We love unit tests but the most important thing for us here is that you finish all of the tasks described below. If
you don't have time remaining to cover the new functionality with tests, that's fine. And if you do, please approach
writing tests with the same care you would take in a real project: for example, use mocks to abstract away external
dependencies, factories to quickly create test data, etc.

**Bonus points** if you find parts of the provided code unidiomatic, inefficient, or unclear and improve it. When you
do that, please leave a comment explaining your reasoning for changing a particular piece of code.


## Tasks

Below is a list of tasks that should be completed in the same order in which they are described.


### Build the Orders web page

Build a web page accessible at /orders that loads all orders from the database and shows them on the page, including
the items belonging to those orders. A number of orders has been prepared for you in `priv/repo/seeds.exs`, those should
be enough to get some data onto the page.

Create a new controller called `OrderController` to handle requests coming to /orders. To get an idea of what the page
should look like, take a look at the basic template in _orders.html_.

You'll notice that there's no action assigned to the "Submit for production" button. Implementing that will be the
last task in this assignment, so don't worry about it for now.


### Write a migration that adds a new vendor to the `vendors` table

Vendor info:

  * code: `packy_pack`
  * name: Packy Pack Ltd
  * address: 715 S Seeley Ave, Chicago, IL 60612, United States

**Bonus points** for documenting best practices for running such migrations in production.


### Add capabilities for the new vendor

This needs to be done in the `Packbox.Vendors.Capabilities` module.

Packy Pack Ltd can produce mailer boxes and shipper boxes that use kraft corrugated cardboard. MOQ (minimum order
quantity) for this vendor is 1 box, and the maximum is 1000 boxes.


### Implement `Packbox.Vendors.all_capable_of_producing_order/1`

This function has to return a list of all vendors that have capabilities for producing all items in the given order.


### Write a migration that creates a new table in the database

The table should be called `vendor_shipping_rates` and it has to have the following columns:

  * `vendor_code`
  * `order_id` - foreign key referencing the `orders` table
  * `shipping_rates` - JSONB array


### Implement `Packbox.Orders.fetch_shipping_rates_for_order/2`

This function will be used in the next task. It should send a request to EasyPost API in order to get shipping rates
for shipping from the given origin address to the customer's address stored on the order. Take a look at the "Tips
for working with EasyPost API" section below to learn how this needs to be implemented.


### Implement `Packbox.Vendors.choose_cheapest_vendor_for_order()`

This is the main part of the assignment. Don't forget to follow best practices and document your thought process
in comments to provide context that cannot be expressed in code alone.

The function needs to do the following:

  * Find all vendors capable of producing the order.

  * For each vendor, pass its address to `Packbox.Orders.fetch_shipping_rates_for_order/2` to get shipping rates.
    Requests for all vendors should run concurrently to speed up the whole process. That is, if multiple vendors are
    capable of producing the order, you must spawn a separate process/task to fetch shipping rates for each vendor.

    **Bonus points** for implementing error handling in case one or more requests return an error (no rates) or fail
     completely (e.g. due to remote host connection failure if the EasyPost API URL is not configured correctly, etc).

  * Pick one vendor with the cheapest shipping rates, store its vendor code on the order and insert a new row into the
    `vendor_shipping_rates` table to store the fetched shipping rates.

  * Transition the order to `:production` state.

If all goes well, the function returns the updated order.

Even If some requests to fetch rates fail, as long as we get at least one response, the function should still pick
the cheapest vendor and return the updated order. Make sure to log encountered errors using Logger so that it's
possible to later find if any errors occurred by searching error logs (assuming they are exported to some external
log aggregation service).

If no rates can be fetched at all, the function returns an error tuple.

Note that you can take some liberty in how the function is structured. For example, if you think it would make more
sense to find all capable vendors in a separate function and then pass that list into `choose_cheapest_vendor_for_order()`
as an argument, go for it. Just please document your reasoning in cases like this in a comment.


### Implement the "Submit for production" button on the Orders page

Remember that button we mentioned in the first task. The time has come to bring it to life. Clicking on it should
result in a call to `Packbox.Vendors.choose_cheapest_vendor_for_orders()` in the backend. If it does find
a capable vendor, the order will end up in the `production` state and the button should be disabled for that order
from now on. If no capable vendor is found for the order, an error must be shown to the user.

Implement handling of the button's action in the same `OrderController` you created in the first task.


## Tips for working with EasyPost API

EasyPost is a service that abstracts away different carriers (USPS, FedEx, DHL, and others) and provides a
well-rounded and easy to use API for creating shipments and purchasing shipping labels.

For the purposes of this assignment, it is sufficient to use a test environment by signing up for a free account on
https://www.easypost.com. Once you sign in, you'll be able to find a test API key to use.

In order to fetch shipping rates, you'll need to define one or more shipments, each one containing a parcel. A parcel
is EasyPost's unit of shipment, it has dimensions (length, width, height) and weight. The dimensions, weights, and
number of parcels needed for a Packbox order vary depending on how many items are in the order and the dimensions and
weights of those.

A single parcel's weight is capped at 1200.0 oz. If a Packbox order does not fit into a single parcel, multiple
shipments need to be created (each shipment containing one parcel) to fetch rates in a single request. Fortunately,
EasyPost provides an endpoint that accepts an order containing multiple shipments. See 
["Create an Order"](https://www.easypost.com/docs/api#create-an-order) in their API docs.

To use that endpoint, you'll need to calculate parcels for a given Packbox order and then build an API request by
including the list of parcels, vendor's origin address, and customer's destination address in the request body. Take
a look at the function stub `Packbox.Orders.fetch_shipping_rates_for_order()` for some guidance.

When building an algorithm for parcel calculation, use the provided `Packbox.Items.calculate_flat_dimensions_for_item()` 
function. It will give you the _length_ and _width_ of the parcel. Parcel _height_ can be calculated by multiplying
the thickness of one sheet (on which the box is printed) by the number of boxes. The thickness depends on the
material. Study the implementation of `calculate_flat_dimensions_for_item()` to see which thickness value to use
for any given material.
