defmodule GamesTest.WordleTest do
  use ExUnit.Case
  doctest Games.Wordle
  alias Games.Wordle

  describe "feedback/2" do
    test "basic" do
      assert Wordle.feedback("word", "word") == [:green, :green, :green, :green]
      assert Wordle.feedback("word", "wore") == [:green, :green, :green, :gray]
      assert Wordle.feedback("word", "wrdo") == [:green, :yellow, :yellow, :yellow]
    end

    test "yellow_count" do
      assert Wordle.feedback("aaabb", "xaaaa") ==
               [:gray, :green, :green, :yellow, :gray]

      assert Wordle.feedback("bbaxa", "xabbb") ==
               [:yellow, :yellow, :yellow, :yellow, :gray]

      assert Wordle.feedback("ababc", "bbabc") ==
               [:gray, :green, :green, :green, :green]
    end
  end
end
