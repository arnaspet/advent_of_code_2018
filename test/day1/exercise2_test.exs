defmodule AdventOfCode.Day1.Exercise2Test do
  use ExUnit.Case

  import AdventOfCode.Day1.Exercise2

  test "regular cases" do
    assert find_duplicate_frequency([1, -1]) == 0
    assert find_duplicate_frequency([3, 3, 4, -2, -4]) == 10
    assert find_duplicate_frequency([-6, 3, 8, 5, -6]) == 5
    assert find_duplicate_frequency([7, 7, -2, -7, -4]) == 14
  end
end
