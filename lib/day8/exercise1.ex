defmodule AdventOfCode.Day8.Exercise1 do
  def solve() do
    AdventOfCode.Utils.FileReader.get_day_string(8)
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> generate_tree()
    |> get_metadata_entries()
    |> Enum.sum()
  end

  @doc """
    gets all metadata entries from tree structure
      iex> AdventOfCode.Day8.Exercise1.get_metadata_entries({{2, 3}, [{{0, 3}, [], [10, 11, 12]}, {{1, 1}, [{{0, 1}, [], [99]}], [2]}], [1, 1, 2]})
      [10, 11, 12, 99, 2, 1, 1, 2]
  """
  def get_metadata_entries({_meta, [], entries}), do: entries

  def get_metadata_entries({_meta, children, entries}) do
    Enum.flat_map(children, fn child -> get_metadata_entries(child) end) ++ entries
  end

  @doc """
    generate tree structure from list of numbers which structure is like:
    node -> {{child_nodes_count, meta_count}, [child_nodes], [meta]}
    
      iex> AdventOfCode.Day8.Exercise1.generate_tree([2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2])
      {{2, 3}, [{{0, 3}, [], [10, 11, 12]}, {{1, 1}, [{{0, 1}, [], [99]}], [2]}], [1, 1, 2]}
  """
  def generate_tree(license) when is_list(license) do
    license |> generate_node |> elem(0)
  end

  defp generate_node([child_nodes_count, meta_count | rest]) when child_nodes_count > 0 do
    {children, rest} =
      Enum.map_reduce(1..child_nodes_count, rest, fn _, rest -> generate_node(rest) end)

    {
      {{child_nodes_count, meta_count}, children, Enum.take(rest, meta_count)},
      Enum.drop(rest, meta_count)
    }
  end

  defp generate_node([0, meta_count | rest]) do
    {
      {{0, meta_count}, [], Enum.take(rest, meta_count)},
      Enum.drop(rest, meta_count)
    }
  end
end
