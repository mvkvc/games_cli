defmodule GamesTest.RockPaperScissorsTest do
  use ExUnit.Case
  doctest Games.RockPaperScissors

  test "beats?/2" do
    assert Games.RockPaperScissors.beats?(:rock, :scissors) == true
    assert Games.RockPaperScissors.beats?(:scissors, :paper) == true
    assert Games.RockPaperScissors.beats?(:paper, :rock) == true
  end
end
