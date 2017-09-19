defmodule Bitracer.Bets do
  use GenServer

  # Client API

  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, :ok, [name: name])
  end

  def read(pid) do
    GenServer.call(pid, {:read})
  end

  def add(pid, item) do
    GenServer.cast(pid, {:add, item})
  end

  def win(pid, winner, odds, names) do
    Enum.each((GenServer.call(pid, {:read})), fn(x) ->
      bet_amount = String.to_integer(x.bet)
      user = Bitracer.Accounts.get_user_by_username!(x.user)
      horse = Bitracer.Records.get_horse_by_name!(names[String.to_atom(x.horse)])
      {:ok, bet} = Bitracer.Records.create_bet(user, horse, %{amount: bet_amount, paid_out: false})
      if x.horse == winner do
        payout = round(bet_amount + (bet_amount * odds))
        BitracerWeb.Endpoint.broadcast! "chat:chat", "incoming_whisper", %{target: x.user, sender: "System", "content": "You won #{payout} coins!"}
        BitracerWeb.UserController.win(x.user, payout)
        require IEx; IEx.pry
        Bitracer.Records.update_bet(bet, %{paid_out: true})
      end
    end)
    BitracerWeb.Endpoint.broadcast! "chat:chat", "incoming_message", %{username: "System", content: "Racer #{String.capitalize(winner)} won!"}
    GenServer.cast(pid, {:reset})
  end

  # Server Callbacks

  def init(:ok) do
    {:ok, []}
  end

  def handle_call({:read}, from, list) do
    {:reply, list, list}
  end

  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end

  def handle_cast({:reset}, list) do
    {:noreply, list = []}
  end
end
