defmodule Bitracer.Game do
  use GenServer

  def random_number do
    Enum.random(1..10) / 10.0
  end

  def random_list do
    for n <- 1..10 do
      random_number
    end
  end

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    BitracerWeb.Endpoint.broadcast! "chat:chat", "game_data", %{content: random_list()}
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 1000)
  end
end
