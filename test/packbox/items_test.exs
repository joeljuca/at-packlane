defmodule Packbox.ItemsTest do
  use Packbox.DataCase

  import Packbox.Factory
  alias Packbox.{Orders, Items}
  alias Packbox.Items.Item
  alias Packbox.Orders.Order
  alias Packbox.Vendors.Vendor

  setup do
    random = %{
      integer: fn -> 1_000_000..9_999_999 |> Enum.random() end
    }

    %Vendor{} = vendor = insert(:vendor)
    %Order{} = order = insert(:order, %{vendor_code: vendor.code})
    %Item{} = item = insert(:item, %{order_id: order.id})

    %{
      item: item,
      order: order,
      random: random,
      vendor: vendor
    }
  end

  describe "get_item!/1" do
    test "requires an existent item ID", %{random: random} do
      assert_raise Ecto.NoResultsError, fn ->
        Items.get_item!(random.integer.())
      end
    end

    test "get an item by its ID", %{item: %{id: item_id}} do
      assert %Item{id: ^item_id} = Items.get_item!(item_id)
    end
  end

  describe "create_item/2" do
    test "requires an order" do
      # TODO
    end

    test "accepts parameters", %{order: order} do
      item_params = params_for(:item, %{order_id: order.id})

      assert {:ok, %Item{}} = Items.create_item(order, item_params)
    end

    test "validate parameters with Item.changeset/2" do
      # TODO
    end

    test "create a new item" do
      # TODO
    end
  end

  describe "update_item/2" do
    test "requires an order and parameters" do
      # TODO
    end

    test "validate parameters with Item.changeset/2" do
      # TODO
    end

    test "update an existing item" do
      # TODO
    end
  end

  describe "change_item/2" do
    test "requires an order" do
      # TODO
    end

    test "accepts optional parameters" do
      # TODO
    end

    test "create a changeset with Item.changeset/2" do
      # TODO
    end
  end
end
