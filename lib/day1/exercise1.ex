defmodule AdventOfCode.Day1.Exercise1 do
  def solve do
    AdventOfCode.Utils.FileReader.get_day_integers(1)
    |> Enum.sum
  end
end
