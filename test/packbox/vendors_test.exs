defmodule Packbox.VendorsTest do
  use Packbox.DataCase

  alias Packbox.Vendors

  describe "vendors" do
    alias Packbox.Vendors.Vendor

    def vendor_fixture() do
      Repo.delete_all(Vendor)

      Packbox.Repo.insert!(%Vendor{
        code: "some code",
        name: "some name",
        address: %{
          street_address: "866 6th Ave",
          city: "New York",
          region: "NY",
          postal_code: "10001",
          country: :USA
        }
      })
    end

    test "list_vendors/0 returns all vendors" do
      vendor = vendor_fixture()
      assert [^vendor] = Vendors.list_vendors()
    end

    test "get_vendor/1 returns the vendor with given ID" do
      %{id: fixture_id} = vendor_fixture()
      vendor = Vendors.get_vendor(fixture_id)

      assert %Vendor{id: ^fixture_id} = vendor
    end

    test "get_vendor!/1 returns the vendor with given code" do
      vendor = vendor_fixture()
      assert Vendors.get_vendor_by_code!(vendor.code) == vendor
    end
  end
end
