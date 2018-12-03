defmodule Day3.Exercise1 do
  @claim_pattern ~r/#(?<claim_id>\d+) @ (?<left>\d+),(?<top>\d+): (?<width>\d+)x(?<height>\d+)/

  def solve do
    File.stream!("#{__DIR__}/../ex1/input.txt")
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list
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

  def convert_to_coordinates(%{"left" => left, "top" => top, "width" => width, "height" => height, "claim_id" => claim_id}) do
    %{
      :top_left => {left + 1, top + 1},
      :top_right => {left + width, top + 1},
      :bottom_left => {left + 1, top + height},
      :bottom_right => {left + width, top + height},
      :claim_id => claim_id
    }
  end

  def fill_grid_with_square(grid \\ %{}, %{top_left: {tlx, tly}, top_right: {trx, _}, bottom_left: {_, bly}, claim_id: id}) do
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

ExUnit.start()

defmodule Day2.Exercise2Test do
  use ExUnit.Case

  import Day3.Exercise1


  test "written case parses claim" do
    assert parse_claim("#1 @ 1,3: 4x4") == %{"height" => 4, "left" => 1, "top" => 3, "width" => 4, "claim_id" => 1}
  end

  """
  ...........
  ...........
  ...#####...
  ...#####...
  ...#####...
  ...#####...
  ...........
  ...........
  ...........
  """
  test "written case calculates square corners" do
    assert convert_to_coordinates(%{"height" => 4, "left" => 3, "top" => 2, "width" => 5, "claim_id" => 4})
           == %{
            :top_left => {4, 3},
            :top_right => {8, 3},
            :bottom_left => {4, 6},
            :bottom_right => {8, 6},
            :claim_id => 4
           }
  end

#  """
#  ....
#  .55.
#  .55.
#  """
  test "fills grid" do
    assert fill_grid_with_square(%{top_left: {2, 2}, top_right: {3,2}, bottom_left: {2, 3}, claim_id: 5}) ==
      %{{2,2} => [5], {2,3} => [5], {3, 2} => [5], {3,3} => [5]}
  end

#  """
#  .....
#  .55..
#  .5X4.
#  ..44.
#  """
  test "fills grid with overlapping values" do
    grid = fill_grid_with_square(%{top_left: {2, 2}, top_right: {3,2}, bottom_left: {2, 3}, claim_id: 5})
    |> fill_grid_with_square(%{top_left: {3, 3}, top_right: {4,3}, bottom_left: {3, 4}, claim_id: 4})

    assert grid == %{{2,2} => [5], {2,3} => [5], {3, 2} => [5], {3,3} => [4, 5], {4,3} => [4], {3,4} => [4], {4,4} => [4]}
  end
end
