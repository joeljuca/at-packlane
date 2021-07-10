defmodule Packbox.Items do
  @moduledoc """
  The Items context.
  """
  alias Packbox.Repo
  alias Packbox.Items.Item

  @doc """
  Get a single item.

  Raises `Ecto.NoResultsError` if the item does not exist.
  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Create a item.
  """
  def create_item(order, params \\ %{}) do
    Ecto.build_assoc(order, :items)
    |> Item.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Update a item.
  """
  def update_item(%Item{} = item, params) do
    item
    |> Item.changeset(params)
    |> Repo.update()
  end

  @doc """
  Return an `%Ecto.Changeset{}` for tracking item changes.
  """
  def change_item(%Item{} = item) do
    Item.changeset(item, %{})
  end

  @caliper_thickness_mailer 1 / 8
  @caliper_thickness_shipper 1 / 16
  @corrugated_glue_tab 1 + 1 / 2

  @caliper_thickness_paperboard 0.02
  @paperboard_glue_tab 3 / 4
  @paperboard_tuck_tab 0.6375

  @doc """
  Given an item, calculate its flat dimensions.

  Flat dimensions refer to the dimensions of the box after it has been printed on a sheet of cardboard and cut to
  size, but before it has been folded up into the final box (at which point it becomes a 3D body with three
  dimensions).
  """
  @spec calculate_flat_dimensions_for_item(%Item{}) :: %{length: float, width: float}
  def calculate_flat_dimensions_for_item(%Item{
        type: :mailer_box,
        length: length,
        width: width,
        depth: depth
      }) do
    flat_length = 20.5 * @caliper_thickness_mailer + 4 * depth + length
    flat_width = 5 * @caliper_thickness_mailer + 3 * depth + 2 * width
    %{length: flat_length, width: flat_width}
  end

  def calculate_flat_dimensions_for_item(%Item{
        type: :shipper_box,
        length: length,
        width: width,
        depth: depth
      }) do
    flat_length = 3 * @caliper_thickness_shipper + depth + width
    flat_width = 3 * @caliper_thickness_shipper + 2 * length + 2 * width + @corrugated_glue_tab
    %{length: flat_length, width: flat_width}
  end

  def calculate_flat_dimensions_for_item(%Item{
        type: :product_box,
        length: length,
        width: width,
        depth: depth
      }) do
    flat_length = 2 * @paperboard_tuck_tab + 2 * width + depth - 3 * @caliper_thickness_paperboard
    flat_width = 2 * length + 2 * width + @paperboard_glue_tab - @caliper_thickness_paperboard
    %{length: flat_length, width: flat_width}
  end
end
