defmodule Packbox.VendorsTest do
  use Packbox.DataCase

  alias Packbox.Vendors

  describe "vendors" do
    alias Packbox.Vendors.Vendor

    def vendor_fixture() do
      Packbox.Repo.insert!(%Vendor{
        code: "some code",
        name: "some name",
        address: %{}
      })
    end

    test "list_vendors/0 returns all vendors" do
      vendor = vendor_fixture()
      assert Vendors.list_vendors() == [vendor]
    end

    test "get_vendor!/1 returns the vendor with given code" do
      vendor = vendor_fixture()
      assert Vendors.get_vendor!(vendor.code) == vendor
    end
  end
end
