defmodule AdventOfCode.Day2.Exercise1Test do
  use ExUnit.Case

  import AdventOfCode.Day2.Exercise1

  test "written cases scores" do
    assert score("abcdef") == {0, 0}
    assert score("bababc") == {1, 1}
    assert score("abbcde") == {1, 0}
    assert score("abcccd") == {0, 1}
    assert score("aabcdd") == {1, 0}
    assert score("abcdee") == {1, 0}
    assert score("ababab") == {0, 1}
  end

  test "written case checksum" do
    assert checksum(["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]) === 12
  end
end
