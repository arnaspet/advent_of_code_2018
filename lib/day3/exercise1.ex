defmodule AdventOfCode.Day3.Exercise1 do
  @claim_pattern ~r/#(?<claim_id>\d+) @ (?<left>\d+),(?<top>\d+): (?<width>\d+)x(?<height>\d+)/

  def solve do
    AdventOfCode.Utils.FileReader.get_day_strings(3)
    |> Enum.map(&parse_claim/1)
    |> Enum.map(&convert_to_coordinates/1)
    |> Enum.reduce(%{}, fn x, acc -> fill_grid_with_square(acc, x) end)
    |> calculate_grid_intersections
  end

  def parse_claim(claim) do
    @claim_pattern
    |> Regex.named_captures(claim)
    |> Enum.into(%{}, fn {key, val} -> {key, String.to_integer(val)} end)
  end

  def convert_to_coordinates(%{
        "left" => left,
        "top" => top,
        "width" => width,
        "height" => height,
        "claim_id" => claim_id
      }) do
    %{
      :top_left => {left + 1, top + 1},
      :top_right => {left + width, top + 1},
      :bottom_left => {left + 1, top + height},
      :bottom_right => {left + width, top + height},
      :claim_id => claim_id
    }
  end

  def fill_grid_with_square(grid \\ %{}, %{
        top_left: {tlx, tly},
        top_right: {trx, _},
        bottom_left: {_, bly},
        claim_id: id
      }) do
    for x <- tlx..trx, y <- tly..bly, into: grid do
      case Map.has_key?(grid, {x, y}) do
        true -> {{x, y}, [id | grid[{x, y}]]}
        false -> {{x, y}, [id]}
      end
    end
  end

  def calculate_grid_intersections(grid) do
    grid
    |> Enum.count(fn {_, x} -> Enum.count(x) > 1 end)
  end
end
