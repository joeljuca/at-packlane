defmodule Packbox.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    # Question: why is there an `order_number` serial field - when `id` is a
    # bigserial, capable of covering very big serialized number scenarios?
    field :order_number, :integer, read_after_write: true
    embeds_one :customer_address, Packbox.Address, on_replace: :update
    field :vendor_code, :string
    field :state, Ecto.Enum, values: [:created, :purchased, :production], default: :created

    has_many :items, Packbox.Items.Item

    timestamps()
  end

  @required_params [:order_number]
  @optional_params [:vendor_code, :state]

  @doc false
  def changeset(order, params) do
    order
    |> cast(params, @required_params ++ @optional_params)
    |> validate_required(@required_params)
    |> cast_embed(:customer_address, required: true)
  end
end
