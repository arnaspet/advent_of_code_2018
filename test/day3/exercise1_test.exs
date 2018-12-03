defmodule AdventOfCode.Day3.Exercise1Test do
  use ExUnit.Case

  import AdventOfCode.Day3.Exercise1

  test "written case parses claim" do
    assert parse_claim("#1 @ 1,3: 4x4") == %{
             "height" => 4,
             "left" => 1,
             "top" => 3,
             "width" => 4,
             "claim_id" => 1
           }
  end

  #  """
  #  ...........
  #  ...........
  #  ...#####...
  #  ...#####...
  #  ...#####...
  #  ...#####...
  #  ...........
  #  ...........
  #  ...........
  #  """
  test "written case calculates square corners" do
    assert convert_to_coordinates(%{
             "height" => 4,
             "left" => 3,
             "top" => 2,
             "width" => 5,
             "claim_id" => 4
           }) ==
             %{
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
    assert fill_grid_with_square(%{
             top_left: {2, 2},
             top_right: {3, 2},
             bottom_left: {2, 3},
             claim_id: 5
           }) == %{{2, 2} => [5], {2, 3} => [5], {3, 2} => [5], {3, 3} => [5]}
  end

  #  """
  #  .....
  #  .55..
  #  .5X4.
  #  ..44.
  #  """
  test "fills grid with overlapping values" do
    grid =
      fill_grid_with_square(%{
        top_left: {2, 2},
        top_right: {3, 2},
        bottom_left: {2, 3},
        claim_id: 5
      })
      |> fill_grid_with_square(%{
        top_left: {3, 3},
        top_right: {4, 3},
        bottom_left: {3, 4},
        claim_id: 4
      })

    assert grid == %{
             {2, 2} => [5],
             {2, 3} => [5],
             {3, 2} => [5],
             {3, 3} => [4, 5],
             {4, 3} => [4],
             {3, 4} => [4],
             {4, 4} => [4]
           }
  end
end
