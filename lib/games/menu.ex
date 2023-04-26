defmodule Games.Menu do
  @moduledoc """
  Menu is the initial menu for the Games library.
  """
  import Games.Utils

  @doc """
  Show the menu and get user input.
  """
  def display do
    display = ~S(
Select a game:
1. Guessing Game
2. Rock Paper Scissors
3. Wordle)

    IO.puts(display)
    selection = get_valid_input("Selection: ", &valid_input?(&1))

    if selection != "stop" do
      case selection do
        "1" -> Games.GuessingGame.play()
        "2" -> Games.RockPaperScissors.play()
        "3" -> Games.Wordle.play()
      end

      display()
    else
      IO.puts("Goodbye!")
      System.halt(0)
    end
  end

  def valid_input?(input) do
    input in ["1", "2", "3"]
  end
end
