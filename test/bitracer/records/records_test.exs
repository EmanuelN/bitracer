defmodule Bitracer.RecordsTest do
  use Bitracer.DataCase

  alias Bitracer.Records

  describe "horses" do
    alias Bitracer.Records.Horse

    @valid_attrs %{losses: 42, name: "some name", wins: 42}
    @update_attrs %{losses: 43, name: "some updated name", wins: 43}
    @invalid_attrs %{losses: nil, name: nil, wins: nil}

    def horse_fixture(attrs \\ %{}) do
      {:ok, horse} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Records.create_horse()

      horse
    end

    test "list_horses/0 returns all horses" do
      horse = horse_fixture()
      assert Records.list_horses() == [horse]
    end

    test "get_horse!/1 returns the horse with given id" do
      horse = horse_fixture()
      assert Records.get_horse!(horse.id) == horse
    end

    test "create_horse/1 with valid data creates a horse" do
      assert {:ok, %Horse{} = horse} = Records.create_horse(@valid_attrs)
      assert horse.losses == 42
      assert horse.name == "some name"
      assert horse.wins == 42
    end

    test "create_horse/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_horse(@invalid_attrs)
    end

    test "update_horse/2 with valid data updates the horse" do
      horse = horse_fixture()
      assert {:ok, horse} = Records.update_horse(horse, @update_attrs)
      assert %Horse{} = horse
      assert horse.losses == 43
      assert horse.name == "some updated name"
      assert horse.wins == 43
    end

    test "update_horse/2 with invalid data returns error changeset" do
      horse = horse_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_horse(horse, @invalid_attrs)
      assert horse == Records.get_horse!(horse.id)
    end

    test "delete_horse/1 deletes the horse" do
      horse = horse_fixture()
      assert {:ok, %Horse{}} = Records.delete_horse(horse)
      assert_raise Ecto.NoResultsError, fn -> Records.get_horse!(horse.id) end
    end

    test "change_horse/1 returns a horse changeset" do
      horse = horse_fixture()
      assert %Ecto.Changeset{} = Records.change_horse(horse)
    end
  end
end
