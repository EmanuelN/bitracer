defmodule BitracerWeb.SessionController do
  use BitracerWeb, :controller
  alias Bitracer.Accounts
  alias Bitracer.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"session" => session_params}) do
    case Bitracer.Session.login(session_params, Bitracer.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end

  def show(conn, _) do
    render conn, "show.html"
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: "/")
  end
end
