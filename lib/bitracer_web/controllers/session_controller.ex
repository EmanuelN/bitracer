defmodule BitracerWeb.SessionController do
  use BitracerWeb, :controller

  def new(conn, _params) do
    render conn, "new.html"
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

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: "/")
  end
end
