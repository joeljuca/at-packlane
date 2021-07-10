defmodule Packbox.OrdersTest do
  use Packbox.DataCase

  alias Packbox.Orders

  @address %{
    "street_address" => "866 6th Ave",
    "city" => "New York",
    "region" => "NY",
    "postal_code" => "10001",
    "country" => "US"
  }

  def vendor_fixture(code) do
    Packbox.Repo.insert!(%Packbox.Vendors.Vendor{
      code: code,
      name: "some name",
      address: %{}
    })
  end

  describe "orders" do
    alias Packbox.Orders.Order

    @valid_params %{
      customer_address: @address,
      order_number: 42,
      state: "created",
      vendor_code: "some vendor"
    }
    @update_params %{
      customer_address: @address,
      order_number: 43,
      state: "purchased",
      vendor_code: "some updated vendor"
    }
    @invalid_params %{customer_address: nil, order_number: nil, state: nil, vendor_code: nil}

    def order_fixture(params \\ %{}) do
      params = Map.merge(@valid_params, params)

      _ = vendor_fixture(params.vendor_code)
      {:ok, order} = Orders.create_order(params)

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      _ = vendor_fixture("some vendor")
      assert {:ok, %Order{} = order} = Orders.create_order(@valid_params)
      assert %Packbox.Address{} = order.customer_address
      assert order.order_number == 42
      assert order.state == :created
      assert order.vendor_code == "some vendor"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_params)
    end

    test "update_order/2 with valid data updates the order" do
      _ = vendor_fixture("some updated vendor")
      order = order_fixture()
      assert {:ok, %Order{} = order} = Orders.update_order(order, @update_params)
      assert order.order_number == 43
      assert order.state == :purchased
      assert order.vendor_code == "some updated vendor"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_params)
      assert order == Orders.get_order!(order.id)
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
