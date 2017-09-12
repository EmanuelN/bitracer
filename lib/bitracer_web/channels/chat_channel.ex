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
    BitracerWeb.UserController.bet(username, bet)
    broadcast! socket, "incoming_notification", %{content: "#{username} bet $#{bet} on #{horse}."}
    {:noreply, socket}
  end
end
