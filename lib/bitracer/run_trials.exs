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
    case result do
      :a ->
        horses = put_in(horses, [:a], put_in(horses[:a], ["wins"], Map.get(horses[:a], "wins") + 1))
        horses = put_in(horses, [:b], put_in(horses[:b], ["losses"], Map.get(horses[:b], "losses") + 1))
        horses = put_in(horses, [:c], put_in(horses[:c], ["losses"], Map.get(horses[:c], "losses") + 1))
        horses = put_in(horses, [:d], put_in(horses[:d], ["losses"], Map.get(horses[:d], "losses") + 1))
        horses = put_in(horses, [:e], put_in(horses[:e], ["losses"], Map.get(horses[:e], "losses") + 1))
        horses
      :b ->
        horses = put_in(horses, [:b], put_in(horses[:b], ["wins"], Map.get(horses[:b], "wins") + 1))
        horses = put_in(horses, [:a], put_in(horses[:a], ["losses"], Map.get(horses[:a], "losses") + 1))
        horses = put_in(horses, [:c], put_in(horses[:c], ["losses"], Map.get(horses[:c], "losses") + 1))
        horses = put_in(horses, [:d], put_in(horses[:d], ["losses"], Map.get(horses[:d], "losses") + 1))
        horses = put_in(horses, [:e], put_in(horses[:e], ["losses"], Map.get(horses[:e], "losses") + 1))
        horses
      :c ->
        horses = put_in(horses, [:c], put_in(horses[:c], ["wins"], Map.get(horses[:c], "wins") + 1))
        horses = put_in(horses, [:a], put_in(horses[:a], ["losses"], Map.get(horses[:a], "losses") + 1))
        horses = put_in(horses, [:b], put_in(horses[:b], ["losses"], Map.get(horses[:b], "losses") + 1))
        horses = put_in(horses, [:d], put_in(horses[:d], ["losses"], Map.get(horses[:d], "losses") + 1))
        horses = put_in(horses, [:e], put_in(horses[:e], ["losses"], Map.get(horses[:e], "losses") + 1))
        horses
      :d ->
        horses = put_in(horses, [:d], put_in(horses[:d], ["wins"], Map.get(horses[:d], "wins") + 1))
        horses = put_in(horses, [:a], put_in(horses[:a], ["losses"], Map.get(horses[:a], "losses") + 1))
        horses = put_in(horses, [:b], put_in(horses[:b], ["losses"], Map.get(horses[:b], "losses") + 1))
        horses = put_in(horses, [:c], put_in(horses[:c], ["losses"], Map.get(horses[:c], "losses") + 1))
        horses = put_in(horses, [:e], put_in(horses[:e], ["losses"], Map.get(horses[:e], "losses") + 1))
        horses
      :e ->
        horses = put_in(horses, [:e], put_in(horses[:e], ["wins"], Map.get(horses[:e], "wins") + 1))
        horses = put_in(horses, [:a], put_in(horses[:a], ["losses"], Map.get(horses[:a], "losses") + 1))
        horses = put_in(horses, [:b], put_in(horses[:b], ["losses"], Map.get(horses[:b], "losses") + 1))
        horses = put_in(horses, [:c], put_in(horses[:c], ["losses"], Map.get(horses[:c], "losses") + 1))
        horses = put_in(horses, [:d], put_in(horses[:d], ["losses"], Map.get(horses[:d], "losses") + 1))
        horses
    end
  end
end
Simulate.race
