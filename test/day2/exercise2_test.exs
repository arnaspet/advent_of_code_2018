defmodule AdventOfCode.Day2.Exercise2Test do
  use ExUnit.Case

  import AdventOfCode.Day2.Exercise2

  test "written case difference" do
    assert calculate_ids_difference("abcde", "axcye") == 2
    assert calculate_ids_difference("fghij", "fguij") == 1
  end

  test "written case list" do
    assert find_nearest_ids(["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]) == {"fghij", "fguij"}
  end

  test "written case common letters" do
    assert get_common_letters("fghij", "fguij") == "fgij"
  end
end
