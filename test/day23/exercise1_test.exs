defmodule AdventOfCode.Day23.Exercise1Test do
  use ExUnit.Case
  import AdventOfCode.Day23.Exercise1

  @input """
  pos=<0,0,0>, r=4
  pos=<1,0,0>, r=1
  pos=<4,0,0>, r=3
  pos=<0,2,0>, r=1
  pos=<0,5,0>, r=3
  pos=<0,0,3>, r=1
  pos=<1,1,1>, r=1
  pos=<1,1,2>, r=1
  pos=<1,3,1>, r=1
  """
  
  @parsed_input %{
    {0, 0, 0} => 4,
    {1, 0, 0} => 1,
    {4, 0, 0} => 3,
    {0, 2, 0} => 1,
    {0, 5, 0} => 3,
    {0, 0, 3} => 1,
    {1, 1, 1} => 1,
    {1, 1, 2} => 1,
    {1, 3, 1} => 1,
  }

  test "parses real input correctly" do
    assert parse(["pos=<86762559,28901997,-40418007>, r=79659980"]) == %{{86762559, 28901997, -40418007} => 79659980}
  end

  test "parses input correctly" do
    input = @input
    |> String.trim_trailing()
    |> String.split("\n")

    assert parse(input) == @parsed_input
  end

  test "in range" do
    assert in_range({{0,0,0},4}, @parsed_input) |> Enum.count() == 7
  end
end
