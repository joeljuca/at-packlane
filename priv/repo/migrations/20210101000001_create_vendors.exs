defmodule Packbox.Repo.Migrations.CreateVendors do
  use Ecto.Migration

  def change do
    create table(:vendors) do
      add :code, :text, null: false
      add :name, :text, null: false
      add :address, :jsonb, null: false

      timestamps()
    end

    create unique_index(:vendors, [:code])
  end
end
