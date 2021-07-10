defmodule Packbox.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :street_address, :string
    field :city, :string
    field :region, :string
    field :postal_code, :string
    field :country, :string
  end

  @required_params ~w[street_address city region postal_code country]a

  def changeset(address, params) do
    address
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
