defmodule Day1.Exercise1 do
  def solve do
    read_file()
    |> parse_integers
    |> Enum.sum
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
