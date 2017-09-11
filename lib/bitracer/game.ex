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
    Enum.random(1..10) / 40.0
  end

  # Reduces speed by random number
  def reducespeed(speed, endurance) do
    newspeed = speed - (1 / endurance) * random_number()
    newspeed
  end

  # update horse's location and speed
  def updatehorse(horse) do
    posx = Map.get(horse, "posx")
    speed = Map.get(horse, "speed")
    endurance = Map.get(horse, "endurance")
    horse = if posx <= 600 do
      Map.put(horse, "posx", posx + speed)
    else
      Map.put(horse, "posx", 600)
    end
    horse = if speed >= 1.0 do
      Map.put(horse, "speed", reducespeed(speed, endurance))
    else
      Map.put(horse, "speed", 1.0)
    end
    horse
  end

  # update horses
  def horse_positions(horses) do
    horses = put_in(horses, [:a], updatehorse(horses[:a]))
    horses = put_in(horses, [:b], updatehorse(horses[:b]))
    horses = put_in(horses, [:c], updatehorse(horses[:c]))
    horses = put_in(horses, [:d], updatehorse(horses[:d]))
    horses = put_in(horses, [:e], updatehorse(horses[:e]))
    horses
  end

  @doc """
  *Inputs:  horses, a list of 5 horses from the JSON file
            framelist, a map consisting of;
                                            frame: the counter representing the current frame
                                            a: a list of x positions for horse a,
                                            b: a list of x positions for horse b,
                                            c: a list of x positions for horse c,
                                            d: a list of x positions for horse d,
                                            e: a list of x positions for horse e
  """
  def race_frames(horses, framelist) do
    if framelist.frame >= 600 do
      framelist = put_in(framelist, [:a], Enum.reverse(framelist.a))
      framelist = put_in(framelist, [:b], Enum.reverse(framelist.b))
      framelist = put_in(framelist, [:c], Enum.reverse(framelist.c))
      framelist = put_in(framelist, [:d], Enum.reverse(framelist.d))
      framelist = put_in(framelist, [:e], Enum.reverse(framelist.e))
      framelist
    else
      framelist = put_in(framelist, [:a], [ Map.get(horses[:a], "posx") | framelist.a ])
      framelist = put_in(framelist, [:b], [ Map.get(horses[:b], "posx") | framelist.b ])
      framelist = put_in(framelist, [:c], [ Map.get(horses[:c], "posx") | framelist.c ])
      framelist = put_in(framelist, [:d], [ Map.get(horses[:d], "posx") | framelist.d ])
      framelist = put_in(framelist, [:e], [ Map.get(horses[:e], "posx") | framelist.e ])
      framelist = put_in(framelist, [:frame], framelist.frame + 1)
      new_positions = horse_positions(horses)
      race_frames(new_positions, framelist)
    end
  end

  #####################################
  ######## GENSERVER CALLBACKS ########
  #####################################

  # def random_list do
  #   Enum.map(1..1200, fn(n) -> race_frames(horses_list(), []) end)
  # end

  def start_link do
    GenServer.start_link(__MODULE__, %{:pos => 0, :frames => race_frames(horses_list(), %{frame: 0, a: [0], b: [0], c: [0], d: [0], e: [0]})})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    game_state = %{
      a: Enum.at(state.frames.a, state[:pos]),
      b: Enum.at(state.frames.b, state[:pos]),
      c: Enum.at(state.frames.c, state[:pos]),
      d: Enum.at(state.frames.d, state[:pos]),
      e: Enum.at(state.frames.e, state[:pos])
    }
    BitracerWeb.Endpoint.broadcast! "chat:chat", "game_data", %{state: game_state}
    state = cond do
      state[:pos] >= 600 ->
        %{state | :frames => race_frames(horses_list(), %{frame: 0, a: [0], b: [0], c: [0], d: [0], e: [0]}), :pos => 0}
      true ->
        %{state | :pos => state[:pos] + 1}
    end
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 100)
  end
end
