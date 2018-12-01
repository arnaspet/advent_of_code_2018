defmodule Day1.Exercise2 do
  def solve do
    read_file()
    |> parse_integers
    |> Enum.to_list
    |> find_duplicate_frequency
  end

  def find_duplicate_frequency(list) do
    find_duplicate_frequency(list, 0, %{0 => true})
  end

  def find_duplicate_frequency([], frequencies_occured) do
    frequencies_occured
  end

  def find_duplicate_frequency([head | tail], last_frequency, frequencies_occured) do
    new_freq = last_frequency + head

    case Map.has_key?(frequencies_occured, new_freq) do
      true -> new_freq
      false -> find_duplicate_frequency(tail ++ [head], new_freq, Map.put_new(frequencies_occured, new_freq, true))
    end
  end

  defp read_file do
    File.stream!("#{__DIR__}/input.txt")
  end

  defp parse_integers(file) do
    file
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&Integer.parse/1)
    |> Stream.map(&(Kernel.elem(&1, 0)))
  end
end


ExUnit.start()

defmodule Day1.Exercise2Test do
  use ExUnit.Case

  import Day1.Exercise2

  test "regular cases" do
    assert find_duplicate_frequency([1, -1]) == 0
    assert find_duplicate_frequency([3, 3, 4, -2, -4]) == 10
    assert find_duplicate_frequency([-6, 3, 8, 5, -6]) == 5
    assert find_duplicate_frequency([7, 7, -2, -7, -4]) == 14
  end
end
