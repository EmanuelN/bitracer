defmodule BitracerWeb.UserController do
  use BitracerWeb, :controller
  require Logger
  alias Bitracer.Accounts
  alias Bitracer.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Bitracer.Registration.create(changeset, Bitracer.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> redirect(to: "/")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> redirect(to: user_path(conn, :index))
  end

  def balance_check(username, coins) do
    user = Accounts.get_user_by_username!(username)
    if user.coins >= String.to_integer(coins) do
      true
    else
      false
    end
  end

  def bet(username, coins) do
    user = Accounts.get_user_by_username!(username)
    new_coins = user.coins - String.to_integer(coins)
    Accounts.update_user(user, %{coins: new_coins})
  end

  def win(username, coins) do
    IO.puts "adding some coins"
    user = Accounts.get_user_by_username!(username)
    new_coins = user.coins + coins
    IO.puts "You used to have #{user.coins} coins"
    IO.puts "Your new coins are #{new_coins}"
    Accounts.update_user(user, %{coins: new_coins})
    BitracerWeb.Endpoint.broadcast! "chat:#{username}", "new_coins", %{coins: new_coins}
  end
end
