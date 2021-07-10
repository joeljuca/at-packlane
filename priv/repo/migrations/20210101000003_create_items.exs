defmodule Packbox.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :type, :text, null: false
      add :name, :text, null: false
      add :width, :float, null: false
      add :length, :float, null: false
      add :depth, :float, null: false
      add :weight, :float, null: false
      add :material, :text, null: false
      add :quantity, :integer, null: false

      add :order_id, references(:orders), null: false

      timestamps()
    end
  end
end
