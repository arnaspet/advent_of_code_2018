defmodule AdventOfCode.Day2.Exercise2 do
  def solve do
    {id1, id2} =
      AdventOfCode.Utils.FileReader.get_day_strings(2)
      |> find_nearest_ids

    get_common_letters(id1, id2)
  end

  def get_common_letters(id1, id2) do
    Enum.zip(String.graphemes(id1), String.graphemes(id2))
    |> List.foldl(
      "",
      fn {x, y}, acc ->
        if x === y, do: acc <> x, else: acc
      end
    )
  end

  def find_nearest_ids(list) do
    for id1 <- list, id2 <- list, calculate_ids_difference(id1, id2) == 1 do
      {id1, id2}
    end
    |> List.first()
  end

  def calculate_ids_difference(id1, id2) do
    Enum.zip(String.graphemes(id1), String.graphemes(id2))
    |> Enum.count(fn {x, y} -> x != y end)
  end
end
