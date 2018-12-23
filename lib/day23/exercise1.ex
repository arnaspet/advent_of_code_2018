defmodule AdventOfCode.Day23.Exercise1 do
  @parse_regex ~r/.*pos=<([-0-9]+),([-0-9]+),([-0-9]+)>, r=([-0-9]+)/

  def solve() do
    bots = AdventOfCode.Utils.FileReader.get_day_strings(23) |> parse()
    strongest_bot = Enum.max_by(bots, fn {_, val} -> val end)

    in_range(strongest_bot, bots) |> Enum.count()
  end

  def in_range({{x, y, z}, r}, nanobots) do
    nanobots
    |> Enum.filter(fn
      {{bx, by, bz}, _} when abs(bx - x) + abs(by - y) + abs(bz - z) <= r -> true
      _ -> false
    end)
  end

  def parse(input) when is_list(input), do: parse(input, %{})
  defp parse([], result), do: result

  defp parse([line | rest], result) do
    [x, y, z, r] =
      Regex.run(@parse_regex, line, capture: :all_but_first) |> Enum.map(&String.to_integer/1)

    parse(rest, Map.put(result, {x, y, z}, r))
  end
end
