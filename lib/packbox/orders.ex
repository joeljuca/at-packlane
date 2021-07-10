defmodule Packbox.Orders do
  @moduledoc """
  The Orders context.
  """
  alias Packbox.Repo
  alias Packbox.Items.Item
  alias Packbox.Orders.Order

  def fetch_shipping_rates_for_order(%Order{} = order, %Packbox.Address{} = origin_address) do
    # TODO: this needs to be implemented.
    #
    # See README.md for details.
  end

  @spec calculate_parcels([%Item{}]) :: [
          %{length: float, width: float, height: float, weight: float}
        ]
  defp calculate_parcels(items) do
  end

  @doc """
  Return the list of orders.
  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Get a single order.

  Raises `Ecto.NoResultsError` if the order does not exist.
  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Create an order.
  """
  def create_order(params \\ %{}) do
    %Order{}
    |> Order.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Update an order.
  """
  def update_order(%Order{} = order, params) do
    order
    |> Order.changeset(params)
    |> Repo.update()
  end

  @doc """
  Return an `%Ecto.Changeset{}` for tracking order changes.
  """
  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end
end
