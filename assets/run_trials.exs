defmodule Simulate do
  @moduledoc """
  Simulates each horse participating in 1000 races, and calculates odds based on that horses win/loss record
  """
  alias Bitracer.Records

  @doc """
  Kicks off each of the 100 horse's simulations and writes the results to horses.json
  """
  def race do
    Enum.each(json(), fn(horse) -> Records.create_horse(%{
      name: Map.get(horse, "name"),
      wins: 0,
      losses: 0
    }) end)
    horses_win_loss_record = Enum.map(json(), &calculate_horse_wl/1)
    
    IO.puts "horses database updated successfully"
  end

  @doc """
  reads horses.json and returns the result
  """
  def json() do
    {:ok, json} = Bitracer.Game.get_json()
    json
  end

  @doc """
  picks the initial 4 to race against and starts the 1000 race loop
  """
  def calculate_horse_wl(horse) do
    list_of_4 = generate_list_of_4(horse)
    horses = run_race(new_horses(horse, list_of_4), 0)
    IO.puts("finished simulating #{Map.get(horse, "name")}")
    horses[:e]
  end

  @doc """
  runs 1000 races against a specified horse
  """
  def run_race(horses, n) do
    if n >= 1000 do
      horses
    else
      result = String.to_atom(Bitracer.Game.race_frames(horses, %{
        frame: 0,
        winner: "",
        a: [],
        b: [],
        c: [],
        d: [],
        e: []
      }).winner)
      horses = update_horse(horses[:e], result)
      run_race(horses, n + 1)
    end
  end

  @doc """
  Generates a new horse list and updates our horse based on whether or not it won the last race
  """
  def update_horse(horse, result) do
    horse_db = Records.get_horse_by_name!(Map.get(horse, "name"))
    case result do
      :e ->
        Records.update_horse(horse_db, %{wins: horse_db.wins + 1})
      _ ->
        Records.update_horse(horse_db, %{losses: horse_db.losses + 1})
    end
    list_of_4 = generate_list_of_4(horse)
    new_horses(horse, list_of_4)
  end

  @doc """
  picks 4 random horses from the JSON, uses recursion to ensure that a horse will not race against itself
  """
  def generate_list_of_4(horse) do
    list_of_4 = Enum.take_random(json(), 5)
    case Enum.member?(list_of_4, horse) do
      true -> generate_list_of_4(horse)
      false -> list_of_4
    end
  end

  @doc """
  returns a new keylist with the passed in horse at :e, and the list of 4 :a-:d
  """
  def new_horses(horse, list_of_4) do
    [
      a: Enum.at(list_of_4, 0), 
      b: Enum.at(list_of_4, 1),
      c: Enum.at(list_of_4, 2),
      d: Enum.at(list_of_4, 3),
      e: horse
    ]
  end
end
#Simulate.race
