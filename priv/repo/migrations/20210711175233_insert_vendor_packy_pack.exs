defmodule Packbox.Repo.Migrations.InsertVendorPackyPack do
  use Ecto.Migration

  alias Packbox.Vendors

  def up do
    Vendors.create_vendor!(%{
      code: "packy_pack",
      name: "Packy Pack Ltd",
      address: %{
        street_address: "715 S Seeley Ave",
        city: "Chicago",
        region: "IL",
        postal_code: "60612",
        country: "United States"
      }
    })
  end

  def down do
    Vendors.get_vendor_by_code!("packy_pack")
    |> Vendors.delete_vendor!()
  end
end
