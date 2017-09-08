defmodule Bitracer.Game do
  require Logger

  use GenServer

  def horses_list do
    [
      a: %{name: "Speedy", age: 4, speed: 5, posx: 0},
      b: %{name: "Horsey", age: 3, speed: 8, posx: 0}
    ]
  end

  # Pseudo-random number between 0 and 1
  def random_number do
    Enum.random(1..10) / 400.0
  end

  # Reduces speed by random number
  def reducespeed(speed) do
    newspeed = speed * (1 - random_number())
    newspeed
  end

  # update horse's location and speed
  def updatehorse(horse) do
    horse = Map.put(horse, :posx, horse.speed)
    horse = Map.put(horse, :speed, reducespeed(horse.speed))
    horse
  end

  # update horses
  def horse_positions(horses) do
    horses = put_in(horses, [:a], updatehorse(horses[:a]))
    horses = put_in(horses, [:b], updatehorse(horses[:b]))
    horses
  end

  def random_list do
    for n <- 1..2 do
      if n == 1 do
        horse_positions(horses_list())[:a]
      else
        horse_positions(horses_list())[:b]
      end
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
