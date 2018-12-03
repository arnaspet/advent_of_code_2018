defmodule AdventOfCode.Utils.FileReader do
  def get_day_strings(day) do
    day
    |> read_file
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list
  end

  def get_day_integers(day) do
    day
    |> read_file
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list
  end

  defp read_file(day) do
    File.stream!("#{File.cwd!}/data/day_#{day}.txt")
  end
end
