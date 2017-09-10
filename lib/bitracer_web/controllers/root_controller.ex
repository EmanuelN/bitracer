defmodule BitracerWeb.RootController do
  use BitracerWeb, :controller

  plug :action

  def new(conn, _params) do
    render conn, "root.html"
  end
end