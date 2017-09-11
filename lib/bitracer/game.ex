defmodule Bitracer.Game do
  use GenServer
  require Logger

  def get_json() do
    with {:ok, body} <- File.read('./horses.json'),
         {:ok, json} <- Poison.decode(body), do: {:ok, json}
  end

  def horses_list do
    {:ok, json} = get_json()
    list = Enum.take_random(json, 5)
    [
      a: Enum.at(list, 0), 
      b: Enum.at(list, 1),
      c: Enum.at(list, 2),
      d: Enum.at(list, 3),
      e: Enum.at(list, 4)
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
    posx = Map.get(horse, "posx")
    speed = Map.get(horse, "speed")
    horse = if posx <= 600 do
      Map.put(horse, "posx", posx + speed)
    else
      Map.put(horse, "posx", 600)
    end
    horse = if speed >= 1.0 do
      Map.put(horse, "speed", reducespeed(speed))
    else
      Map.put(horse, "speed", 1.0)
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

  #####################################
  ######## GENSERVER CALLBACKS ########
  #####################################

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
    #a = elem(Enum.at(state[:list], state[:pos]), 1)
    #b = elem(Enum.at(state[:list], state[:pos]+1), 1)
    #BitracerWeb.Endpoint.broadcast! "chat:chat", "game_data", %{horse_a: a, horse_b: b}
    state = cond do
      state[:pos] >= 1200 ->
        %{state | :list => race_frames(horses_list(), []), :pos => 0}
      true ->
        %{state | :pos => state[:pos] + 2}
    end
#TODO: remove this, for debugging purposes
#IO.puts inspect state
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 1000)
  end
end
