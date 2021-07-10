defmodule Packbox.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :order_number, :serial, null: false
      add :customer_address, :jsonb, null: false
      add :vendor_code, references(:vendors, column: :code, type: :text)
      add :state, :text, null: false

      timestamps()
    end
  end
end
