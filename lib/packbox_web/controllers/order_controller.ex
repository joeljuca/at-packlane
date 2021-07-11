defmodule PackboxWeb.OrderController do
  use PackboxWeb, :controller

  import Ecto.Query
  alias Packbox.Items.Item
  alias Packbox.Orders.Order
  alias Packbox.Repo

  def index(conn, _params) do
    # FYI, if I was going to implement pagination, I would implement a
    # cursor-based strategy. But it requires some energy - so I'm skipping it.
    #
    # See: Markus Winand (Use the Index, Luke) on cursor-based pagination https://use-the-index-luke.com/blog/2013-07/pagination-done-the-postgresql-way
    query =
      from order in Order,
        left_join: item in Item,
        on: order.id == item.order_id,
        select: order,
        preload: [:items]

    products = query |> Repo.all()

    render(conn, "index.html", products: products)
  end
end
