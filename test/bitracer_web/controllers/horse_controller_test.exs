defmodule BitracerWeb.HorseControllerTest do
  use BitracerWeb.ConnCase

  alias Bitracer.Records

  @create_attrs %{losses: 42, name: "some name", wins: 42}
  @update_attrs %{losses: 43, name: "some updated name", wins: 43}
  @invalid_attrs %{losses: nil, name: nil, wins: nil}

  def fixture(:horse) do
    {:ok, horse} = Records.create_horse(@create_attrs)
    horse
  end

  describe "index" do
    test "lists all horses", %{conn: conn} do
      conn = get conn, horse_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Horses"
    end
  end

  describe "new horse" do
    test "renders form", %{conn: conn} do
      conn = get conn, horse_path(conn, :new)
      assert html_response(conn, 200) =~ "New Horse"
    end
  end

  describe "create horse" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, horse_path(conn, :create), horse: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == horse_path(conn, :show, id)

      conn = get conn, horse_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Horse"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, horse_path(conn, :create), horse: @invalid_attrs
      assert html_response(conn, 200) =~ "New Horse"
    end
  end

  describe "edit horse" do
    setup [:create_horse]

    test "renders form for editing chosen horse", %{conn: conn, horse: horse} do
      conn = get conn, horse_path(conn, :edit, horse)
      assert html_response(conn, 200) =~ "Edit Horse"
    end
  end

  describe "update horse" do
    setup [:create_horse]

    test "redirects when data is valid", %{conn: conn, horse: horse} do
      conn = put conn, horse_path(conn, :update, horse), horse: @update_attrs
      assert redirected_to(conn) == horse_path(conn, :show, horse)

      conn = get conn, horse_path(conn, :show, horse)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, horse: horse} do
      conn = put conn, horse_path(conn, :update, horse), horse: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Horse"
    end
  end

  describe "delete horse" do
    setup [:create_horse]

    test "deletes chosen horse", %{conn: conn, horse: horse} do
      conn = delete conn, horse_path(conn, :delete, horse)
      assert redirected_to(conn) == horse_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, horse_path(conn, :show, horse)
      end
    end
  end

  defp create_horse(_) do
    horse = fixture(:horse)
    {:ok, horse: horse}
  end
end
