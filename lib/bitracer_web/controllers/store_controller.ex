defmodule BitracerWeb.StoreController do
  use BitracerWeb, :controller

  plug :action

  def new(conn, _params) do
    render conn, "store.html"
  end

end