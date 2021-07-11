defmodule Packbox.Vendors do
  @moduledoc """
  The Vendors context.
  """

  import Ecto.Query
  import Packbox.Vendors.Capabilities
  alias Packbox.Repo
  alias Packbox.Orders.Order
  alias Packbox.Vendors.Vendor

  def list_vendors, do: Repo.all(Vendor)

  def get_vendor(id), do: Repo.get(Vendor, id)

  def get_vendor!(id), do: Repo.get!(Vendor, id)

  def get_vendor_by_code(code), do: Repo.get_by(Vendor, code: code)

  def get_vendor_by_code!(code), do: Repo.get_by!(Vendor, code: code)

  def create_vendor(params \\ %{}), do: %Vendor{} |> Vendor.changeset(params) |> Repo.insert()

  def create_vendor!(params \\ %{}), do: %Vendor{} |> Vendor.changeset(params) |> Repo.insert!()

  def update_vendor(%Vendor{} = vendor, params) do
    vendor
    |> Vendor.changeset(params)
    |> Repo.update()
  end

  def update_vendor!(%Vendor{} = vendor, params) do
    vendor
    |> Vendor.changeset(params)
    |> Repo.update!()
  end

  def delete_vendor(%Vendor{} = vendor), do: Repo.delete(vendor)

  def delete_vendor!(%Vendor{} = vendor), do: Repo.delete!(vendor)

  def change_vendor(%Vendor{} = vendor), do: vendor |> Vendor.changeset(%{})

  def all_capable_of_producing_order(%Order{} = order) do
    # I'm splitting the load of vendor codes and full vendor data because, given
    # a scenario where we have lots of vendors, we'll be creating a bottleneck
    # by loading too many data to then discart later.

    query =
      from vendor in Vendor,
        select: [vendor.code]

    all_vendor_codes = query |> Repo.all()

    capable_vendor_codes =
      all_vendor_codes
      |> Enum.filter(fn vendor_code ->
        order.items
        |> Enum.reduce(true, fn item, is_capable ->
          is_capable and vendor_capable_of_producing_item?(vendor_code, item.type)
        end)
      end)

    capable_vendors =
      from vendor in Vendor,
        where: vendor.code in ^capable_vendor_codes

    capable_vendors
  end

  def choose_cheapest_vendor_for_order(%Order{} = _order) do
    # TODO: this needs to be implemented.
    #
    # See README.md for details.
  end
end
