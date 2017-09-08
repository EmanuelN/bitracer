defmodule Bitracer.Game do
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
    Logger.debug "reducing speed to #{newspeed}"
    newspeed
  end

  def updatehorse(horse) do
    Logger.debug horse.name
    Logger.debug horse.speed
    horse = Map.put(horse, :posx, horse.speed)
    horse = Map.put(horse, :speed, reducespeed(horse.speed))
    horse
  end

  def horse_positions(horses) do
    horses = put_in(horses, [:a], updatehorse(horses[:a]))
    horses = put_in(horses, [:a], updatehorse(horses[:b]))
    horses
  end

end