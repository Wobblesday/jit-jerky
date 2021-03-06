defmodule JITJerky.ShippingTest do
  use JITJerky.DataCase

  alias JITJerky.Shipping

  describe "addresses" do
    alias JITJerky.Shipping.Address

    @valid_attrs %{address_line1: "some address_line1", address_line2: "some address_line2", city: "some city", country: "some country", delivery_instructions: %{}, name: "some name", postal_code: "some postal_code", province: "some province", telephone: "some telephone"}
    @update_attrs %{address_line1: "some updated address_line1", address_line2: "some updated address_line2", city: "some updated city", country: "some updated country", delivery_instructions: %{}, name: "some updated name", postal_code: "some updated postal_code", province: "some updated province", telephone: "some updated telephone"}
    @invalid_attrs %{address_line1: nil, address_line2: nil, city: nil, country: nil, delivery_instructions: nil, name: nil, postal_code: nil, province: nil, telephone: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shipping.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Shipping.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Shipping.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Shipping.create_address(@valid_attrs)
      assert address.address_line1 == "some address_line1"
      assert address.address_line2 == "some address_line2"
      assert address.city == "some city"
      assert address.country == "some country"
      assert address.delivery_instructions == %{}
      assert address.name == "some name"
      assert address.postal_code == "some postal_code"
      assert address.province == "some province"
      assert address.telephone == "some telephone"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shipping.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Shipping.update_address(address, @update_attrs)
      assert address.address_line1 == "some updated address_line1"
      assert address.address_line2 == "some updated address_line2"
      assert address.city == "some updated city"
      assert address.country == "some updated country"
      assert address.delivery_instructions == %{}
      assert address.name == "some updated name"
      assert address.postal_code == "some updated postal_code"
      assert address.province == "some updated province"
      assert address.telephone == "some updated telephone"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Shipping.update_address(address, @invalid_attrs)
      assert address == Shipping.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Shipping.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Shipping.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Shipping.change_address(address)
    end
  end
end
