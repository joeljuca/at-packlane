defmodule Packbox.Vendors.Capabilities do
  @moduledoc """
  Here we define capabilities for each vendor in the system.
  """
  alias Packbox.Types
  alias Packbox.Items.Item

  @doc """
  Check whether the vendor can produce the given item by testing various item attributes against vendor's
  capabilities.
  """
  @spec vendor_capable_of_producing_item?(String.t(), %Packbox.Items.Item{}) :: boolean
  def vendor_capable_of_producing_item?(vendor_code, %Item{} = item)
      when is_binary(vendor_code) do
    can_produce_item_type?(vendor_code, item.type) and
      can_produce_material?(vendor_code, item.material) and
      can_produce_quantity?(vendor_code, item.quantity)
  end

  @spec can_produce_item_type?(String.t(), Types.box_type()) :: boolean
  defp can_produce_item_type?("happy_box", type), do: type in [:mailer_box, :shipper_box]
  defp can_produce_item_type?("rigid_cartons", type), do: type in [:mailer_box, :product_box]
  defp can_produce_item_type?(_, _), do: false

  @spec can_produce_material?(String.t(), Types.material()) :: boolean
  defp can_produce_material?("happy_box", material),
    do: material in [:kraft_corrugated, :white_corrugated]

  defp can_produce_material?("rigid_cartons", material),
    do: material in [:white_corrugated, :paperboard]

  defp can_produce_material?(_, _), do: false

  @spec can_produce_quantity?(String.t(), pos_integer) :: boolean
  defp can_produce_quantity?("happy_box", quantity), do: quantity >= 25
  defp can_produce_quantity?("rigid_cartons", quantity), do: quantity >= 10
  defp can_produce_quantity?(_, _), do: true
end
