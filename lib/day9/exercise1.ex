defmodule AdventOfCode.Day9.Exercise1 do
  defmodule Game do
    defstruct board: [], player_scores: [], current_marble_index: 0
  end

  def solve() do
    find_winning_score(428, 72061)
  end

  def find_winning_score(players_count, last_marble) do
    game = %Game{
      player_scores: List.duplicate(0, players_count),
      board: [0],
      current_marble_index: 0
    }

    finished_game = Enum.reduce(1..last_marble, game, fn x, acc -> place_marble(x, acc) end)

    Enum.max(finished_game.player_scores)
  end

  def place_marble(marble, game) when rem(marble, 23) == 0 do
    scored_players_index =
      case Integer.mod(marble, length(game.player_scores)) - 1 do
        -1 -> length(game.player_scores) - 1
        other -> other
      end

    {element_7, board} = pop_7th_element_from_board(game)
    {new_index, _} = get_marble(game, -7)

    game
    |> update_in(
      [Access.key!(:player_scores), Access.at(scored_players_index)],
      &(&1 + marble + element_7)
    )
    |> put_in([Access.key!(:board)], board)
    |> put_in([Access.key!(:current_marble_index)], new_index)
  end

  def place_marble(marble, game) do
    new_index = get_insertion_index(game)

    update_in(game.board, &List.insert_at(&1, new_index, marble))
    |> put_in([Access.key!(:current_marble_index)], new_index)
  end

  defp get_insertion_index(%Game{board: board}) when length(board) == 0, do: 0

  defp get_insertion_index(game) do
    case get_marble(game, 2) do
      {0, _} -> length(game.board)
      {other, _} -> other
    end
  end

  defp pop_7th_element_from_board(game) do
    {index, _} = get_marble(game, -7)

    List.pop_at(game.board, index)
  end

  defp get_marble(%Game{board: board}) when length(board) == 0, do: {0, 0}

  defp get_marble(%Game{current_marble_index: index, board: board}, steps) do
    marble_index = Integer.mod(index + steps, length(board))

    {marble_index, Enum.at(board, marble_index)}
  end
end
