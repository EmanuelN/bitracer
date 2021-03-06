defmodule Bitracer.Game do
  use GenServer
  require Logger
  alias Bitracer.Records

  @doc """
  reads the file 'horses.json' and returns our list of 100 horses.
  """
  def get_json() do
    with {:ok, body} <- File.read('./horses.json'),
         {:ok, json} <- Poison.decode(body), do: {:ok, json}
  end

  @doc """
  returns a key-value list of 5 horses which are randomly chosen from the list of 100
  """
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

  @doc """
  Pseudo-random number between 0 and 1
  """
  def random_number do
    #Enum.random(1..10) / 25.0
    :rand.uniform()
  end

  @doc """
  Reduces speed by random number
  has a one in ten chance to drop speed to 1
  """
  def reducespeed(speed, endurance) do
    newspeed = case Float.round(random_number(), 1) do
      0.1 -> 1
      _ -> speed - (1 / endurance) * random_number()
    end
    newspeed
  end

  @doc """
  redemption! has a one in ten chance of boosting to 5, one in ten chance of doing nothing,
  and four fifths of the time it increases speed by between 1 and 0.1
  """
  def redemption(speed, chance) do
    newspeed = case Float.round(random_number(), 1) do
      0.1 -> 1
      0.5 -> 5
      _ -> speed + (1 / chance)
    end
    newspeed
  end

  @doc """
  update horse's location and speed
  """
  def updatehorse(horse) do
    posx = Map.get(horse, "posx")
    speed = Map.get(horse, "speed")
    endurance = Map.get(horse, "endurance")
    chance = Map.get(horse, "chance")
    horse = if posx <= 600 do
      Map.put(horse, "posx", posx + speed)
    else
      Map.put(horse, "posx", 600)
      Map.put(horse, "finished", true)
    end
    horse = if speed >= 1.0 do
      Map.put(horse, "speed", reducespeed(speed, endurance))
    else
      Map.put(horse, "speed", redemption(speed, chance))
    end
    horse
  end

  @doc """
  update horses
  calls updatehorse on each horse in the list 'horses', and then returns the list of horses
  """
  def horse_positions(horses) do
    horses = put_in(horses, [:a], updatehorse(horses[:a]))
    horses = put_in(horses, [:b], updatehorse(horses[:b]))
    horses = put_in(horses, [:c], updatehorse(horses[:c]))
    horses = put_in(horses, [:d], updatehorse(horses[:d]))
    horses = put_in(horses, [:e], updatehorse(horses[:e]))
    horses
  end

  @doc """
  Calculates the entire list of frames for each horse, at 10 FPS
  *Inputs:  horses, a list of 5 horses from the JSON file
            framelist, a map consisting of; frame: the counter representing the current frame
                                            a: a list of x positions for horse a,
                                            b: a list of x positions for horse b,
                                            c: a list of x positions for horse c,
                                            d: a list of x positions for horse d,
                                            e: a list of x positions for horse e
  *Outputs: framelist, a map consisting of; frame: the counter representing the current frame
                                            a: a list of x positions for horse a,
                                            b: a list of x positions for horse b,
                                            c: a list of x positions for horse c,
                                            d: a list of x positions for horse d,
                                            e: a list of x positions for horse e
  """
  def race_frames(horses, framelist) do
    cond do
      framelist.frame >= 600 ->
        framelist = put_in(framelist, [:a], Enum.reverse(framelist.a))
        framelist = put_in(framelist, [:b], Enum.reverse(framelist.b))
        framelist = put_in(framelist, [:c], Enum.reverse(framelist.c))
        framelist = put_in(framelist, [:d], Enum.reverse(framelist.d))
        framelist = put_in(framelist, [:e], Enum.reverse(framelist.e))
        framelist

      framelist.frame == 0 ->
        horse_a = Records.get_horse_by_name(Map.get(horses[:a], "name"))
        horse_b = Records.get_horse_by_name(Map.get(horses[:b], "name"))
        horse_c = Records.get_horse_by_name(Map.get(horses[:c], "name"))
        horse_d = Records.get_horse_by_name(Map.get(horses[:d], "name"))
        horse_e = Records.get_horse_by_name(Map.get(horses[:e], "name"))
        if horse_a && horse_b && horse_c && horse_d && horse_e do
          odds_a = horse_a.losses / if horse_a.wins != 0, do: horse_a.wins, else: 1
          odds_b = horse_b.losses / if horse_b.wins != 0, do: horse_b.wins, else: 1
          odds_c = horse_c.losses / if horse_c.wins != 0, do: horse_c.wins, else: 1
          odds_d = horse_d.losses / if horse_d.wins != 0, do: horse_d.wins, else: 1
          odds_e = horse_e.losses / if horse_e.wins != 0, do: horse_e.wins, else: 1
          framelist = put_in(framelist, [:odds], %{
            a: odds_a,
            b: odds_b,
            c: odds_c,
            d: odds_d,
            e: odds_e
          })
        end
        framelist = put_in(framelist, [:names], %{
          a: Map.get(horses[:a], "name"),
          b: Map.get(horses[:b], "name"),
          c: Map.get(horses[:c], "name"),
          d: Map.get(horses[:d], "name"),
          e: Map.get(horses[:e], "name")
        })
        framelist = put_in(framelist, [:a], [ 0 | framelist.a ])
        framelist = put_in(framelist, [:b], [ 0 | framelist.b ])
        framelist = put_in(framelist, [:c], [ 0 | framelist.c ])
        framelist = put_in(framelist, [:d], [ 0 | framelist.d ])
        framelist = put_in(framelist, [:e], [ 0 | framelist.e ])
        framelist = put_in(framelist, [:frame], framelist.frame + 1)
        race_frames(horses, framelist)

      framelist.frame <= 150 ->
        framelist = put_in(framelist, [:a], [ 0 | framelist.a ])
        framelist = put_in(framelist, [:b], [ 0 | framelist.b ])
        framelist = put_in(framelist, [:c], [ 0 | framelist.c ])
        framelist = put_in(framelist, [:d], [ 0 | framelist.d ])
        framelist = put_in(framelist, [:e], [ 0 | framelist.e ])
        framelist = put_in(framelist, [:frame], framelist.frame + 1)
        race_frames(horses, framelist)

      true ->
        framelist = put_in(framelist, [:a], [ Map.get(horses[:a], "posx") | framelist.a ])
        framelist = put_in(framelist, [:b], [ Map.get(horses[:b], "posx") | framelist.b ])
        framelist = put_in(framelist, [:c], [ Map.get(horses[:c], "posx") | framelist.c ])
        framelist = put_in(framelist, [:d], [ Map.get(horses[:d], "posx") | framelist.d ])
        framelist = put_in(framelist, [:e], [ Map.get(horses[:e], "posx") | framelist.e ])
        framelist = put_in(framelist, [:frame], framelist.frame + 1)

        win = framelist.winner
        len = String.length(win)
        framelist = case Enum.any?(horses, fn({_key, horse}) -> Map.get(horse, "finished") end)  do
          true when win == "" ->
            winner = Enum.map_join(horses, fn({key, horse}) -> if Map.get(horse, "finished"), do: key end)
            framelist = put_in(framelist, [:winner], winner)
            framelist = put_in(framelist, [:winner_odds], framelist[:odds][String.to_atom(winner)])
            framelist
          true when len > 1 ->
            put_in(framelist, [:winner], String.slice(win, 0, 1))
          _ ->
            framelist
        end

        new_positions = horse_positions(horses)
        race_frames(new_positions, framelist)
    end
  end

  def update_database(names, winner) do
    Enum.each(names, fn({key, value}) ->
      horse_db = Records.get_horse_by_name!(value)
      if key == String.to_atom(winner) do
        Records.update_horse(horse_db, %{wins: horse_db.wins + 1})
      else
        Records.update_horse(horse_db, %{losses: horse_db.losses + 1})
      end
    end)
  end

  #####################################
  ######## GENSERVER CALLBACKS ########
  #####################################

  @doc """
  starts the GenServer with a state: pos = 0, frames = race_frames
  """
  def start_link do
    GenServer.start_link(__MODULE__, %{
      :pos => 0,
      :frames => race_frames(horses_list(), %{
        frame: 0,
        winner: "",
        winner_odds: 0,
        odds: %{},
        names: %{},
        a: [0],
        b: [0],
        c: [0],
        d: [0],
        e: [0]
      })
    })
  end

  @doc """
  called immediately after GenServer is started, starts the initial stateful loop
  """
  def init(state) do
    schedule_work()
    {:ok, state}
  end

  @doc """
  main function responsible for talking to the frontend, sends a game_state map representing the current x positions for a..e
  then checks if 600 frames have elapsed (1 minute at 10FPS), and if so then it fetches a new framelist from race_frames
  otherwise increment pos by 1 and schedule itself again
  """
  def handle_info(:work, state) do
    game_state = %{
      a: Enum.at(state.frames.a, state[:pos]),
      b: Enum.at(state.frames.b, state[:pos]),
      c: Enum.at(state.frames.c, state[:pos]),
      d: Enum.at(state.frames.d, state[:pos]),
      e: Enum.at(state.frames.e, state[:pos])
    }
    BitracerWeb.Endpoint.broadcast! "chat:chat", "game_data", %{state: game_state}
    BitracerWeb.Endpoint.broadcast! "chat:chat", "odds", state.frames.odds
    BitracerWeb.Endpoint.broadcast! "chat:chat", "names", state.frames.names
    BitracerWeb.Endpoint.broadcast! "chat:chat", "pos", %{pos: state[:pos]}
    state = cond do
      state[:pos] >= 600 ->
        Bitracer.Bets.win(:bookie, state.frames.winner, state.frames.winner_odds, state.frames.names)
        update_database(state.frames.names, state.frames.winner)
        %{state | :frames => race_frames(horses_list(), %{
          frame: 0,
          winner: "",
          winner_odds: 0,
          odds: %{},
          names: %{},
          a: [0],
          b: [0],
          c: [0],
          d: [0],
          e: [0]
        }), :pos => 0}
      true ->
        %{state | :pos => state[:pos] + 1}
    end
    cond do
      Enum.at(state.frames.a, state[:pos]) >= 600 ->
        BitracerWeb.Endpoint.broadcast! "chat:chat", "winner_data", %{winner: state.frames.winner}
      Enum.at(state.frames.b, state[:pos]) >= 600 ->
        BitracerWeb.Endpoint.broadcast! "chat:chat", "winner_data", %{winner: state.frames.winner}
      Enum.at(state.frames.c, state[:pos]) >= 600 ->
        BitracerWeb.Endpoint.broadcast! "chat:chat", "winner_data", %{winner: state.frames.winner}
      Enum.at(state.frames.d, state[:pos]) >= 600 ->
        BitracerWeb.Endpoint.broadcast! "chat:chat", "winner_data", %{winner: state.frames.winner}
      Enum.at(state.frames.e, state[:pos]) >= 600 ->
        BitracerWeb.Endpoint.broadcast! "chat:chat", "winner_data", %{winner: state.frames.winner}
      true ->
        BitracerWeb.Endpoint.broadcast! "chat:chat", "winner_data", %{winner: ""}
    end
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 100)
  end
end
