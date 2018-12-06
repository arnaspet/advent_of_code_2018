defmodule AdventOfCode.Day5.Exercise2PerformanceComparison do
  import AdventOfCode.Day5.Exercise2

  def test_async_vs_sync() do
    string = AdventOfCode.Utils.FileReader.get_day_string(5)

    Benchee.run(%{
      "sync"    => fn -> find_shortest_possible_polymer(string) end,
      "async" => fn -> find_shortest_possible_polymer_async(string) end
    })
  end
end
