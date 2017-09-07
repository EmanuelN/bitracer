defmodule BitracerWeb.ChatChannel do
  use Phoenix.Channel

  def join("chat:chat", _message, socket) do
    {:ok, socket}
  end

  def join("chat:" <> _private, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
end
