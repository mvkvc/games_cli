defmodule Games.GuessingGame do
  @moduledoc """
  Numbers guessing game.
  """
  import Games.Utils
  @max 10

  @doc """
  Runs the game loop.
  """
  def play(opts \\ []) do
    target = Keyword.get(opts, :target, Enum.random(1..@max))
    lives = Keyword.get(opts, :lives, 3)

    if !opts[:target] do
      IO.puts("Welcome to Guessing Game")
      IO.puts("Pick a number between 0 and #{@max}")
    end

    IO.puts("You have #{lives} lives left")

    input = get_valid_input("GG Guess: ", &valid_input?(&1))

    if input != "stop" do
      guess = Integer.parse(input) |> elem(0)

      cond do
        guess == target ->
          IO.puts("Correct!")

        lives == 1 ->
          IO.puts("You lose! The number was #{target}")

        guess < target ->
          IO.puts("Too low!")
          play(target: target, lives: lives - 1)

        guess > target ->
          IO.puts("Too high!")
          play(target: target, lives: lives - 1)
      end
    end
  end

  defp valid_input?(guess) do
    parsed = Integer.parse(guess)

    cond do
      parsed == :error ->
        IO.puts("Invalid guess: must be an integer.")
        false

      elem(parsed, 0) not in 1..@max ->
        IO.puts("Invalid guess: allowed values are 1 to #{@max}")
        false

      true ->
        true
    end
  end
end
