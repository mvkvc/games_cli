defmodule Games.RockPaperScissors do
  @moduledoc """
  Rock Paper Scissors game.
  """
  import Games.Utils

  @doc """
  Runs the game loop.
  """
  def play(opts \\ []) do
    score = Keyword.get(opts, :score, 0)

    if !opts[:score], do: IO.puts("Welcome to Rock Paper Scissors")
    IO.puts("Your score is #{score}")

    guess = get_valid_input("RPS Guess: ", &valid_input?(&1))

    IO.inspect(guess)

    if guess != "stop" do
      guess = String.to_existing_atom(guess)
      opponent = Enum.random([:rock, :paper, :scissors])

      cond do
        guess == opponent ->
          IO.puts("Draw with #{guess}!")
          play(score: score)

        beats?(guess, opponent) ->
          IO.puts("You win! You played #{guess} and your opponent played #{opponent}")
          play(score: score + 1)

        beats?(opponent, guess) ->
          IO.puts("You lose! You played #{guess} and your opponent played #{opponent}")
          play(score: score - 1)
      end
    end
  end

  defp beats?(player1, player2) do
    {player1, player2} in [{:rock, :scissors}, {:scissors, :paper}, {:paper, :rock}]
  end

  defp valid_input?(input) do
    cond do
      input in ["rock", "paper", "scissors"] ->
        true

      true ->
        IO.puts("Input must be rock, paper or scissors.")
        false
    end
  end
end
