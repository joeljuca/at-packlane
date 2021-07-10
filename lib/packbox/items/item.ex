defmodule Packbox.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :type, Ecto.Enum, values: [:mailer_box, :shipper_box, :product_box]
    field :name, :string
    field :width, :float
    field :length, :float
    field :depth, :float
    field :weight, :float
    field :material, Ecto.Enum, values: [:kraft_corrugated, :white_corrugated, :paperboard]
    field :quantity, :integer

    belongs_to :order, Packbox.Orders.Order

    timestamps()
  end

  @required_params ~w[type name width length depth weight material quantity]a

  @doc false
  def changeset(item, params) do
    item
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
