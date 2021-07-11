defmodule Packbox.Vendors do
  @moduledoc """
  The Vendors context.
  """

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

  def all_capable_of_producing_order(%Order{} = _order) do
    # TODO: this needs to be implemented.
    #
    # See README.md for details.
  end

  def choose_cheapest_vendor_for_order(%Order{} = _order) do
    # TODO: this needs to be implemented.
    #
    # See README.md for details.
  end
end
