defmodule BitracerWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:chat", _message, socket) do
    {:ok, socket}
  end

  def join("chat:" <> _private, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("post_message", %{"username" => username, "content" => content}, socket) do
    broadcast! socket, "incoming_message", %{username: username, content: content}
    {:noreply, socket}
  end

  def handle_in("post_notification", %{"content" => content}, socket) do
    broadcast! socket, "incoming_notification", %{content: content}
    {:noreply, socket}
  end

  def handle_in("post_bet", %{"username" => username, "bet" => bet, "horse" => horse}, socket) do
    if String.to_integer(bet) > 0 && String.to_integer(bet) <= 100 do
      if BitracerWeb.UserController.balance_check(username, bet) do
        Bitracer.Bets.add(Bitracerbets, %{user: username, horse: horse, bet: bet})
        IO.puts List.first(Bitracer.Bets.read(Bitracerbets)).bet
        IO.puts List.last(Bitracer.Bets.read(Bitracerbets)).bet
        BitracerWeb.UserController.bet(username, bet)
        broadcast! socket, "incoming_notification", %{content: "#{username} bet $#{bet} on #{horse}."}
        {:noreply, socket}
      else
        broadcast! socket, "incoming_whisper", %{content: "You lack sufficient funds for this bet", target: username, sender: "System"}
        {:noreply, socket}
      end
    else
      broadcast! socket, "incoming_whisper", %{content: "You must enter a bet between 1 and 100", target: username, sender: "System"}
      {:noreply, socket}
    end
  end

  def handle_in("post_whisper", %{"target" => target, "content" => content, "sender" => sender}, socket) do
    broadcast! socket, "incoming_whisper", %{content: content, target: target, sender: sender}
    {:noreply, socket}
  end
end