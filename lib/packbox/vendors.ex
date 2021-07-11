defmodule Packbox.Vendors do
  @moduledoc """
  The Vendors context.
  """
  alias Packbox.Repo
  alias Packbox.Orders.Order
  alias Packbox.Vendors.Vendor

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

  @doc """
  Return all vendors.
  """
  def list_vendors do
    Repo.all(Vendor)
  end

  @doc """
  Get a single vendor by its code.

  Raises `Ecto.NoResultsError` if the vendor does not exist.
  """
  def get_vendor!(code) when is_binary(code), do: Repo.get_by!(Vendor, code: code)
end
