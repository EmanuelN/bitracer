defmodule Bitracer.Game do
  use GenServer
  require Logger

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
    if horse.posx <= 600 do
      horse = Map.put(horse, :posx, horse.posx + horse.speed)
    end
    if horse.speed >= 1.0 do
      horse = Map.put(horse, :speed, reducespeed(horse.speed))
    end
    horse
  end

  # update horses
  def horse_positions(horses) do
    horses = put_in(horses, [:a], updatehorse(horses[:a]))
    horses = put_in(horses, [:b], updatehorse(horses[:b]))
    horses
  end

  def race_frames(horses, framelist) do
    if length(framelist) >= 1200 do
      framelist
    else
      newframes = framelist ++ horses
      new_positions = horse_positions(horses)
      race_frames(new_positions, newframes)
    end
  end

  # def random_list do
  #   Enum.map(1..1200, fn(n) -> race_frames(horses_list(), []) end)
  # end

  def start_link do
    GenServer.start_link(__MODULE__, %{:pos => 0, :list => race_frames(horses_list(), [])})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    a = elem(Enum.at(state[:list], state[:pos]), 1)
    b = elem(Enum.at(state[:list], state[:pos]+1), 1)
    BitracerWeb.Endpoint.broadcast! "chat:chat", "game_data", %{horse_a: a, horse_b: b}
    state = cond do
      state[:pos] >= 1200 ->
        %{state | :list => race_frames(horses_list(), []), :pos => 0}
      true ->
        %{state | :pos => state[:pos] + 2}
    end
#TODO: remove this, for debugging purposes
IO.puts inspect state
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 1000)
  end
end
