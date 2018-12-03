defmodule AdventOfCode.Day3.Exercise2Test do
  use ExUnit.Case

  import AdventOfCode.Day3.Exercise2

  test "gets non overlapping ids" do
    assert get_not_overlapping_ids(%{
             {1, 1} => [2, 3],
             {0, 0} => [1],
             {2, 2} => [5],
             {4, 4} => [1, 2, 3]
           }) == MapSet.new([5])
  end
end
