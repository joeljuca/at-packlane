defmodule Packbox.ItemsTest do
  use Packbox.DataCase

  alias Packbox.{Orders, Items}

  @address %{
    "street_address" => "866 6th Ave",
    "city" => "New York",
    "region" => "NY",
    "postal_code" => "10001",
    "country" => "US",
    "country_name" => "United States"
  }

  @order_params %{
    customer_address: @address,
    order_number: 42
  }

  describe "items" do
    alias Packbox.Items.Item

    @valid_params %{
      depth: 120.5,
      length: 120.5,
      material: "kraft_corrugated",
      name: "some name",
      quantity: 42,
      type: "mailer_box",
      width: 120.5,
      weight: 0.01
    }
    @update_params %{
      depth: 456.7,
      length: 456.7,
      material: "white_corrugated",
      name: "some updated name",
      quantity: 43,
      type: "shipper_box",
      width: 456.7,
      weight: 0.02
    }
    @invalid_params %{
      depth: nil,
      length: nil,
      material: nil,
      name: nil,
      quantity: nil,
      type: nil,
      width: nil
    }

    def item_fixture(params \\ %{}) do
      {:ok, order} = Orders.create_order(@order_params)

      params = Map.merge(@valid_params, params)
      {:ok, item} = Items.create_item(order, params)

      item
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      {:ok, order} = Orders.create_order(@order_params)
      assert {:ok, %Item{} = item} = Items.create_item(order, @valid_params)
      assert item.depth == 120.5
      assert item.length == 120.5
      assert item.material == :kraft_corrugated
      assert item.name == "some name"
      assert item.quantity == 42
      assert item.type == :mailer_box
      assert item.width == 120.5
      assert item.weight == 0.01
    end

    test "create_item/1 with invalid data returns error changeset" do
      {:ok, order} = Orders.create_order(@order_params)
      assert {:error, %Ecto.Changeset{}} = Items.create_item(order, @invalid_params)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, %Item{} = item} = Items.update_item(item, @update_params)
      assert item.depth == 456.7
      assert item.length == 456.7
      assert item.material == :white_corrugated
      assert item.name == "some updated name"
      assert item.quantity == 43
      assert item.type == :shipper_box
      assert item.width == 456.7
      assert item.weight == 0.02
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_params)
      assert item == Items.get_item!(item.id)
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
