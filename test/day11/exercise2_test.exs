defmodule AdventOfCode.Day11.Exercise2Test do
  use ExUnit.Case
  import  AdventOfCode.Day11.Exercise2

  test "constructs summed-area table correctly" do
    map = %{
      {1, 1} => 31, {2, 1} => 2, {3, 1} => 4, {4, 1} => 33, {5, 1} => 5,{6, 1} => 36,
      {1, 2} => 12, {2, 2} => 26, {3, 2} => 9, {4, 2} => 10, {5, 2} => 29,{6, 2} => 25,
      {1, 3} => 13, {2, 3} => 17, {3, 3} => 21, {4, 3} => 22, {5, 3} => 20,{6, 3} => 18,
      {1, 4} => 24, {2, 4} => 23, {3, 4} => 15, {4, 4} => 16, {5, 4} => 14,{6, 4} =>19,
      {1, 5} => 30, {2, 5} => 8, {3, 5} => 28, {4, 5} => 27, {5, 5} => 11,{6, 5} => 7,
      {1, 6} => 1, {2, 6} => 35, {3, 6} => 34, {4, 6} => 3, {5, 6} => 32,{6, 6} => 6,
    }

    summed_table = get_summed_area_table(map, {6, 6})
    assert get_area_sum(summed_table, {0, 0}, {2, 2}) === 71
    assert get_area_sum(summed_table, {2, 3}, {5, 5}) === 111
  end
end
