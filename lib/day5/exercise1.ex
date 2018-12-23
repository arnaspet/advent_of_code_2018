 defmodule AdventOfCode.Day5.Exercise1 do
  def solve() do
    AdventOfCode.Utils.FileReader.get_day_string(5)
    |> trigger_reaction
    |> String.length()
  end

  @doc """
    In aA, a and A react, leaving nothing behind.
    In abBA, bB destroys itself, leaving aA. As above, this then destroys itself, leaving nothing.
    In abAB, no two adjacent units are of the same type, and so nothing happens.
    In aabAAB, even though aa and AA are of the same type, their polarities match, and so nothing happens.

      iex> AdventOfCode.Day5.Exercise1.trigger_reaction("aA")
      ""
      iex> AdventOfCode.Day5.Exercise1.trigger_reaction("abBA")
      ""
      iex> AdventOfCode.Day5.Exercise1.trigger_reaction("abAB")
      "abAB"
      iex> AdventOfCode.Day5.Exercise1.trigger_reaction("aabAAB")
      "aabAAB"
  """
  def trigger_reaction(polimers) when is_binary(polimers) do
    polimers
    |> String.to_charlist()
    |> trigger_reaction()
  end

  def trigger_reaction(polimers) when is_list(polimers) do
    after_reaction = remove_polymers(polimers, [])

    case polimers == after_reaction do
      true -> String.Chars.to_string(after_reaction)
      false -> trigger_reaction(after_reaction)
    end
  end

  defp remove_polymers([], result), do: Enum.reverse(result)
  defp remove_polymers([polymer], result), do: Enum.reverse([polymer | result])

  defp remove_polymers([po1, po2 | rest], result) do
    case reacts?(po1, po2) do
      true -> remove_polymers(rest, result)
      false -> remove_polymers([po2 | rest], [po1 | result])
    end
  end

  defp reacts?(x, y), do: abs(x - y) === 32
end
