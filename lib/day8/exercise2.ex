defmodule AdventOfCode.Day8.Exercise2 do
  import AdventOfCode.Day8.Exercise1

  def solve() do
    AdventOfCode.Utils.FileReader.get_day_string(8)
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> generate_tree()
    |> get_node_value()
  end

  def get_node_value(nil), do: 0
  def get_node_value({_header, [], metadata}), do: Enum.sum(metadata)

  def get_node_value({_header, children, metadata}) do
    metadata
    |> Enum.map(fn
      x when x == 0 -> 0
      x -> children |> Enum.at(x - 1) |> get_node_value()
    end)
    |> Enum.sum()
  end
end
