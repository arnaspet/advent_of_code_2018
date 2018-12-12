defmodule AdventOfCode.Day11.Exercise2 do
  import AdventOfCode.Day11.Exercise1

  def solve() do
    generate_grid(5535)
    |> get_summed_area_table({300, 300})
    |> find_max_sum_square
  end

  def find_max_sum_square(summed_area_table) do
    for x <- 0..300,
        y <- 0..300,
        square_size <- 1..300,
        x + square_size <= 300,
        y + square_size <= 300 do
      sum = get_area_sum(summed_area_table, {x, y}, {x + square_size, y + square_size})

      {{x + 1, y + 1, square_size}, sum}
    end
    |> Enum.max_by(fn {_, val} -> val end)
  end

  def get_summed_area_table(grid, {width, height}) do
    Enum.reduce(1..width, %{}, fn x, acc ->
      Enum.reduce(1..height, acc, fn y, acc ->
        sum =
          get_safe_map_val(grid, {x, y}) + get_safe_map_val(acc, {x - 1, y}) +
            get_safe_map_val(acc, {x, y - 1}) - get_safe_map_val(acc, {x - 1, y - 1})

        Map.put(acc, {x, y}, sum)
      end)
    end)
  end

  def get_area_sum(
        summed_area_table,
        {top_left_x, top_left_y} = top_left,
        {bottom_right_x, bottom_right_y} = bottom_right
      ) do
    get_safe_map_val(summed_area_table, bottom_right) +
      get_safe_map_val(summed_area_table, top_left) -
      get_safe_map_val(summed_area_table, {bottom_right_x, top_left_y}) -
      get_safe_map_val(summed_area_table, {top_left_x, bottom_right_y})
  end

  defp get_safe_map_val(map, key) do
    case map[key] do
      nil -> 0
      key -> key
    end
  end
end
