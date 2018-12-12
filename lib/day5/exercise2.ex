defmodule AdventOfCode.Day5.Exercise2 do
  import AdventOfCode.Day5.Exercise1

  def solve() do
    AdventOfCode.Utils.FileReader.get_day_string(5)
    |> find_shortest_possible_polymer
    |> String.length()
  end

  @doc """
    gets polymer and finds shortest variation

      iex>AdventOfCode.Day5.Exercise2.find_shortest_possible_polymer("dabAcCaCBAcCcaDA")
      "daDA"
  """
  def find_shortest_possible_polymer(polymer) do
    polymer
    |> get_unique_polymers()
    |> Stream.map(fn x -> remove_type_of_polymer(polymer, x) end)
    |> Stream.map(&AdventOfCode.Day5.Exercise1.trigger_reaction/1)
    |> Enum.min_by(&String.length/1)
  end

  @doc """
    gets polymer and finds shortest variation

      iex>AdventOfCode.Day5.Exercise2.find_shortest_possible_polymer("dabAcCaCBAcCcaDA")
      "daDA"
  """
  def find_shortest_possible_polymer_async(polymer) do
    polymer
    |> get_unique_polymers()
    |> Stream.map(fn x -> remove_type_of_polymer(polymer, x) end)
    |> Task.async_stream(&AdventOfCode.Day5.Exercise1.trigger_reaction/1)
    |> Enum.min_by(fn {:ok, str} -> String.length(str) end)
    |> elem(1)
  end

  @doc """
    Removes specified polymier from string

      iex> AdventOfCode.Day5.Exercise2.remove_type_of_polymer("dabAcCaCBAcCcaDA", ?a)
      "dbcCCBcCcD"
  """
  def remove_type_of_polymer(polymer, type) do
    polymer
    |> String.replace(String.downcase(<<type>>), "")
    |> String.replace(String.upcase(<<type>>), "")
  end

  defp get_unique_polymers(polymer) do
    polymer
    |> String.to_charlist()
    |> MapSet.new()
    |> Enum.filter(&(&1 > 96))
  end
end
