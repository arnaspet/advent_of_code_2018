defmodule AdventOfCode.Day11.Exercise1 do
  def solve() do
    generate_grid(5535)
    |> chunk_by_3x3_squares
    |> Enum.max_by(fn x -> x |> Map.values() |> Enum.sum() end)
    |> Enum.at(0)
    |> elem(0)
  end

  def generate_grid(serial) do
    for x <- 1..300, y <- 1..300, into: %{} do
      {{x, y}, get_power_level({x, y}, serial)}
    end
  end

  def chunk_by_3x3_squares(grid) do
    for x <- 1..298, y <- 1..298 do
      Map.take(grid, generate_grid_keys({x, x + 2}, {y, y + 2}))
    end
  end

  def generate_grid_keys({x_from, x_to}, {y_from, y_to}) do
    for x <- x_from..x_to, y <- y_from..y_to do
      {x, y}
    end
  end

  @doc """
    iex>AdventOfCode.Day11.Exercise1.get_power_level({3,5}, 8)
    4
    iex>AdventOfCode.Day11.Exercise1.get_power_level({122,79}, 57)
    -5
    iex>AdventOfCode.Day11.Exercise1.get_power_level({217,196}, 39)
    0
    iex>AdventOfCode.Day11.Exercise1.get_power_level({101,153}, 71)
    4
  """
  def get_power_level({x, y}, serial) do
    rack_id = x + 10
    power_level = (rack_id * y + serial) * rack_id
    hundreds_digit = power_level |> Integer.to_string() |> String.at(-3) |> String.to_integer()

    hundreds_digit - 5
  end
end
