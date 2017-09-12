defmodule Simulate do
  #use Bitracer.Game
  def run do
    {:ok, json} = Bitracer.Game.get_json()
    list_of_5 = Enum.take_random(json, 5)
    horses = run_race([
      a: Enum.at(list_of_5, 0), 
      b: Enum.at(list_of_5, 1),
      c: Enum.at(list_of_5, 2),
      d: Enum.at(list_of_5, 3),
      e: Enum.at(list_of_5, 4)
    ], 0)
    
    IO.puts inspect horses, limit: :infinity, pretty: true
    IO.puts inspect(find_by_name(Map.get(horses[:a], "name"), json), limit: :infinity, pretty: true)
  end
  defp find_by_name(name, list) do
    Enum.find(list, fn n -> 
      Map.get(n, "name") == name
    end)
  end
  defp run_race(horses, n) do
    if n >= 100 do
      horses
    else
      result = String.to_atom(Bitracer.Game.race_frames(horses, %{frame: 0, winner: "", a: [], b: [], c: [], d: [], e: []}).winner)
      horses = update_horses(horses, result)
      run_race(horses, n + 1)
    end
  end
  defp update_horses(horses, result) do
    #require IEx; IEx.pry
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
Simulate.run
