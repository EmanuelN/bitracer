defmodule Simulate do

  def race do
    horses_win_loss_record = Enum.map(json(), &calculate_horse_wl/1)
    
    File.write!("./horses.json", Poison.encode!(horses_win_loss_record))
    IO.puts "horses.json updated successfully"
  end

  defp json() do
    {:ok, json} = Bitracer.Game.get_json()
    json
  end

  defp calculate_horse_wl(horse) do
    list_of_4 = generate_list_of_4(horse)
    horses = run_race([
      a: Enum.at(list_of_4, 0), 
      b: Enum.at(list_of_4, 1),
      c: Enum.at(list_of_4, 2),
      d: Enum.at(list_of_4, 3),
      e: horse
    ], 0)
    IO.puts("finished simulating #{Map.get(horse, "name")}")
    horses[:e]
  end

  defp generate_list_of_4(horse) do
    list_of_4 = Enum.take_random(json(), 5)
    case Enum.member?(list_of_4, horse) do
      true -> generate_list_of_4(horse)
      false -> list_of_4
    end
  end

  defp run_race(horses, n) do
    if n >= 1000 do
      horses
    else
      result = String.to_atom(Bitracer.Game.race_frames(horses, %{frame: 0, winner: "", a: [], b: [], c: [], d: [], e: []}).winner)
      horses = update_horses(horses, result)
      run_race(horses, n + 1)
    end
  end

  defp update_horses(horses, result) do
    horse = horses[:e]
    horse = case result do
      :e ->
        put_in(horse, ["wins"], Map.get(horse, "wins") + 1)
      _ ->
        put_in(horse, ["losses"], Map.get(horse, "losses") + 1)
    end
    list_of_4 = generate_list_of_4(horse)
    [
      a: Enum.at(list_of_4, 0), 
      b: Enum.at(list_of_4, 1),
      c: Enum.at(list_of_4, 2),
      d: Enum.at(list_of_4, 3),
      e: horse
    ] 
  end
end
Simulate.race
