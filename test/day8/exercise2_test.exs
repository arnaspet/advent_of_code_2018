defmodule AdventOfCode.Day8.Exercise2Test do
  use ExUnit.Case
  import AdventOfCode.Day8.Exercise2

  test "if node has no child nodes its value is the sum of its metadata entries" do
    assert get_node_value({{0, 3}, [], [1, 2, 3]}) === 6
  end

  test "if node has children then its value is sum of its children metadata sum" do
    assert get_node_value({
             {2, 3},
             [
               {{0, 3}, [], [11, 11, 11]},
               {{0, 3}, [], [22, 22, 22]}
             ],
             [2]
           }) === 66
  end

  test "if reference child doest exist that reference is skipped" do
    assert get_node_value({
             {2, 3},
             [
               {{0, 3}, [], [11, 11, 11]},
               {{0, 3}, [], [22, 2, 22]}
             ],
             [3]
           }) === 0
  end

  test "metadata entry of 0 does not refer to any child node" do
    assert get_node_value({
             {2, 3},
             [
               {{0, 3}, [], [11, 11, 11]},
               {{0, 3}, [], [22, 2, 22]}
             ],
             [0]
           }) === 0
  end
end
