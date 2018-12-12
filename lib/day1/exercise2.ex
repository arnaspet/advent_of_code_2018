defmodule AdventOfCode.Day1.Exercise2 do
  def solve do
    AdventOfCode.Utils.FileReader.get_day_integers(1)
    |> find_duplicate_frequency
  end

  def find_duplicate_frequency(list) do
    find_duplicate_frequency(list, 0, %{0 => true})
  end

  def find_duplicate_frequency([head | tail], last_frequency, frequencies_occured) do
    new_freq = last_frequency + head

    case Map.has_key?(frequencies_occured, new_freq) do
      true ->
        new_freq

      false ->
        find_duplicate_frequency(
          tail ++ [head],
          new_freq,
          Map.put_new(frequencies_occured, new_freq, true)
        )
    end
  end
end
