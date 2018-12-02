defmodule Day2.Exercise1 do
  def solve do
    File.stream!("#{__DIR__}/input.txt")
    |> checksum
  end

  def checksum(ids) do
    {twos_count, threes_count} = ids
    |> Enum.map(&score/1)
    |> List.foldl({0, 0}, fn {x, y}, {acc_2, acc_3} -> {acc_2 + x, acc_3 + y}  end)

    twos_count * threes_count
  end

  def score(box_id) do
    letter_occurences =
      box_id
      |> String.graphemes()
      |> Enum.sort()
      |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
      |> Map.values()

    {
      letter_occurences |> Enum.member?(2) |> bool_to_int,
      letter_occurences |> Enum.member?(3) |> bool_to_int
    }
  end

  defp bool_to_int(true), do: 1
  defp bool_to_int(false), do: 0
end

ExUnit.start()

defmodule Day2.Exercise1Test do
  use ExUnit.Case

  import Day2.Exercise1

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
