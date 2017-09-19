defmodule BitracerWeb.BetController do
  use BitracerWeb, :controller

  alias Bitracer.Records

  def index(conn, _params) do
    bets = Records.list_bets()
    render(conn, "index.html", bets: bets)
  end

  def show(conn, %{"id" => id}) do
    bet = Records.get_bet!(id)
    render(conn, "show.html", bet: bet)
  end
end
