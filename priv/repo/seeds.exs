# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Packbox.Repo.insert!(%Packbox.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Packbox.Address
alias Packbox.Repo

alias Packbox.Items.Item
alias Packbox.Orders.Order
alias Packbox.Vendors.Vendor

### Vendors ###

Repo.insert!(%Vendor{
  code: "happy_box",
  name: "Happy Box Inc.",
  address: %Address{
    street_address: "7301 River Rd",
    city: "North Bergen",
    region: "NJ",
    postal_code: "07047",
    country: "US"
  }
})

Repo.insert!(%Vendor{
  code: "rigid_cartons",
  name: "Rigid Cartons",
  address: %Address{
    street_address: "13701 E 116th St",
    city: "Fishers",
    region: "IN",
    postal_code: "46037",
    country: "US"
  }
})

### Orders ###

Repo.insert!(%Order{
  items: [
    %Item{
      name: "Mailer Box - 11.5 x 9 x 6",
      type: :mailer_box,
      material: :kraft_corrugated,
      quantity: 10,
      length: 11.5,
      width: 9.0,
      depth: 6.0,
      weight: 10.0
    }
  ],
  customer_address: %Address{
    street_address: "2380 W US Hwy 89A",
    city: "Sedona",
    region: "AZ",
    postal_code: "86336",
    country: "US"
  }
})

Repo.insert!(%Order{
  items: [
    %Item{
      name: "Shipper Box - 10.5 x 9.5 x 5.5",
      type: :shipper_box,
      material: :white_corrugated,
      quantity: 100,
      length: 10.5,
      width: 9.5,
      depth: 5.5,
      weight: 20.0
    }
  ],
  customer_address: %Address{
    street_address: "1185 Arnold Dr",
    city: "Matrinez",
    region: "CA",
    postal_code: "94553",
    country: "US"
  }
})

Repo.insert!(%Order{
  items: [
    %Item{
      name: "Product Box - 2.25 x 2.25 x 6",
      type: :product_box,
      material: :paperboard,
      quantity: 250,
      length: 2.25,
      width: 2.25,
      depth: 6.0,
      weight: 8.0
    },
    %Item{
      name: "Product Box - 2.5 x 2.5 x 2.5",
      type: :product_box,
      material: :paperboard,
      quantity: 570,
      length: 2.5,
      width: 2.5,
      depth: 2.5,
      weight: 6.5
    }
  ],
  customer_address: %Address{
    street_address: "2205 McDermott Rd",
    city: "Plano",
    region: "TX",
    postal_code: "75025",
    country: "US"
  }
})

Repo.insert!(%Order{
  items: [
    %Item{
      name: "Shipper Box - 16 x 8 x 8",
      type: :mailer_box,
      material: :kraft_corrugated,
      quantity: 900,
      length: 16.0,
      width: 8.0,
      depth: 8.0,
      weight: 23.25
    }
  ],
  customer_address: %Address{
    street_address: "6000 Sinclair Rd",
    city: "Columbus",
    region: "OH",
    postal_code: "43229",
    country: "US"
  }
})
