defmodule Packbox.Vendors.Vendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vendors" do
    field :name, :string
    field :code, :string
    embeds_one :address, Packbox.Address

    timestamps()
  end

  @required_params ~w[name code]a

  @doc false
  def changeset(vendor, params) do
    vendor
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> cast_embed(:address, required: true)
  end
end
