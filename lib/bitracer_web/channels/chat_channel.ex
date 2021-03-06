defmodule BitracerWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:chat", _message, socket) do
    {:ok, socket}
  end

  def join("chat:" <> username, _params, socket) do
    send(self(), {:user_join, username})
    {:ok, socket}
  end

  def handle_info({:user_join, username}, socket) do
    user = Bitracer.Accounts.get_user_by_username(username)
    if user, do: broadcast! socket, "new_coins", %{coins: user.coins}
    {:noreply, socket}
  end

  def handle_in("post_message", %{"username" => username, "content" => content}, socket) do
    broadcast! socket, "incoming_message", %{username: username, content: content}
    {:noreply, socket}
  end

  def handle_in("post_notification", %{"content" => content}, socket) do
    broadcast! socket, "incoming_notification", %{content: content}
    {:noreply, socket}
  end

  def handle_in("post_bet", %{"username" => username, "bet" => bet, "horse" => horse, "name" => name}, socket) do
    if String.to_integer(bet) > 0 && String.to_integer(bet) <= 100 do
      if BitracerWeb.UserController.balance_check(username, bet) do
        Bitracer.Bets.add(:bookie, %{user: username, horse: horse, bet: bet})
        BitracerWeb.UserController.bet(username, bet)
        broadcast! socket, "incoming_notification", %{content: "#{username} bet $#{bet} on #{name}."}
        user = Bitracer.Accounts.get_user_by_username!(username)
        BitracerWeb.Endpoint.broadcast! "chat:#{username}", "new_coins", %{coins: user.coins}
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
