defmodule Day2.Exercise2 do
  def solve do
    {id1, id2} =
      File.stream!("#{__DIR__}/../ex1/input.txt")
      |> Stream.map(&String.trim_trailing/1)
      |> find_nearest_ids

    get_common_letters(id1, id2)
  end

  def get_common_letters(id1, id2) do
    Enum.zip(String.graphemes(id1), String.graphemes(id2))
    |> List.foldl(
      "",
      fn {x, y}, acc ->
        if x === y, do: acc <> x, else: acc
      end
    )
  end

  def find_nearest_ids(list) do
    for id1 <- list, id2 <- list, calculate_ids_difference(id1, id2) == 1 do
      {id1, id2}
    end
    |> List.first()
  end

  def calculate_ids_difference(id1, id2) do
    Enum.zip(String.graphemes(id1), String.graphemes(id2))
    |> Enum.count(fn {x, y} -> x != y end)
  end
end

ExUnit.start()

defmodule Day2.Exercise2Test do
  use ExUnit.Case

  import Day2.Exercise2

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
