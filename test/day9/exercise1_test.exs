defmodule AdventOfCode.Day9.Exercise1Test do
  use ExUnit.Case
  import AdventOfCode.Day9.Exercise1
  alias AdventOfCode.Day9.Exercise1.Game

  test "places marble that are 1 and 2 marbles clockwise of current marble" do
    game = %Game{player_scores: [0], board: [0], current_marble_index: 0}

    assert game =
             %Game{player_scores: [0], board: [0, 1], current_marble_index: 1} =
             place_marble(1, game)

    assert game =
             %Game{player_scores: [0], board: [0, 2, 1], current_marble_index: 1} =
             place_marble(2, game)

    assert game =
             %Game{player_scores: [0], board: [0, 2, 1, 3], current_marble_index: 3} =
             place_marble(3, game)
  end

  test "if marble is multiple of 23 add that marble to players score + 7 marbles back" do
    game = %Game{
      player_scores: [0, 0, 0, 0, 0, 0, 0, 0, 0],
      board: [0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
      current_marble_index: 13
    }

    game_after = %Game{
      player_scores: [0, 0, 0, 0, 32, 0, 0, 0, 0],
      board: [0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
      current_marble_index: 6
    }

    assert place_marble(23, game) == game_after
  end

  test "written cases" do
    assert find_winning_score(10, 1618) == 8317
    assert find_winning_score(13, 7999) == 146_373
    assert find_winning_score(17, 1104) == 2764
    assert find_winning_score(21, 6111) == 54718
    assert find_winning_score(30, 5807) == 37305
  end
end
