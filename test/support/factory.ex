defmodule Packbox.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Packbox.Repo

  alias Packbox.Address
  alias Packbox.Items.Item
  alias Packbox.Orders.Order
  alias Packbox.Vendors.Vendor

  def address_factory(attrs \\ %{}) do
    %Address{
      street_address: Map.get(attrs, :street_address) || Faker.Address.En.street_address(),
      city: Map.get(attrs, :city) || Faker.Address.En.city(),
      region: Map.get(attrs, :region) || Faker.Address.En.state_abbr(),
      postal_code: Map.get(attrs, :postal_code) || Faker.Address.En.zip_code(),
      country: Map.get(attrs, :country) || :USA
    }
  end

  def item_factory(%{order_id: _} = attrs) do
    %Item{
      order_id: attrs.order_id,
      type: Map.get(attrs, :type) || [:mailer_box, :shipper_box, :product_box] |> Enum.random(),
      name: Map.get(attrs, :name) || Faker.Commerce.product_name(),
      width: Map.get(attrs, :width) || 5..15 |> Enum.random(),
      length: Map.get(attrs, :length) || 5..15 |> Enum.random(),
      depth: Map.get(attrs, :depth) || 5..15 |> Enum.random(),
      weight: Map.get(attrs, :weight) || 5..15 |> Enum.random(),
      material:
        Map.get(attrs, :material) ||
          [:kraft_corrugated, :white_corrugated, :paperboard] |> Enum.random(),
      quantity: Map.get(attrs, :quantity) || 5..15 |> Enum.random()
    }
  end

  def order_factory(%{vendor_code: vendor_code} = attrs)
      when is_bitstring(vendor_code) do
    %Order{
      vendor_code: attrs.vendor_code,
      order_number: 1_000_000..9_999_999 |> Enum.random(),
      customer_address: address_factory(),
      state: [:created, :purchased, :production] |> Enum.random(),
      items: Map.get(attrs, :items) || []
    }
  end

  def vendor_factory(attrs \\ %{}) do
    %Vendor{
      code:
        Map.get(attrs, :code) ||
          Ecto.UUID.generate()
          |> String.split("-")
          |> Enum.take(1)
          |> Enum.at(0),
      name: Map.get(attrs, :name) || Faker.Company.name(),
      address: Map.get(attrs, :name) || address_factory()
    }
  end
end
