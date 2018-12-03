defmodule AdventOfCode.Day3.Exercise2 do
  import AdventOfCode.Day3.Exercise1

  def solve do
    AdventOfCode.Utils.FileReader.get_day_strings(3)
    |> Enum.map(&parse_claim/1)
    |> Enum.map(&convert_to_coordinates/1)
    |> Enum.reduce(%{}, fn x, acc -> fill_grid_with_square(acc, x) end)
    |> get_not_overlapping_ids
    |> Enum.at(0)
  end

  def get_not_overlapping_ids(grid) do
    MapSet.difference(get_all_ids(grid), get_overlapping_ids(grid))
  end

  def get_all_ids(grid) do
    grid
    |> Enum.unzip()
    |> Kernel.elem(1)
    |> Enum.concat()
    |> MapSet.new()
  end

  def get_overlapping_ids(grid) do
    grid
    |> Enum.reduce(MapSet.new(), fn
      {_, [_]}, acc -> acc
      {_, list}, acc -> for x <- list, into: acc, do: x
    end)
  end
end
