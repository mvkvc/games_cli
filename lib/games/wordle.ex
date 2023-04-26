defmodule Games.Wordle do
  @moduledoc """
  This is a word guessing game. The player is given a word and must guess the word by entering a word with the same
  length. The player has 5 lives and loses a life for each incorrect guess. The player wins if they guess the word
  correctly before they run out of lives.
  """
  import Games.Utils

  @words "priv/words.txt"
  @guesses "priv/guesses.txt"

  @doc """
  Returns a list of words from the given file path.
  """
  def get_text(path) do
    File.stream!(path)
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
  end

  @doc """
  Runs the game loop.
  """
  def play(opts \\ []) do
    word = Keyword.get(opts, :word, Enum.random(get_text(@words)))
    guess_list = Keyword.get(opts, :guess_list, get_text(@guesses))
    lives = Keyword.get(opts, :lives, 5)

    if !opts[:word] do
      IO.puts("Welcome to Wordle")
      IO.puts("Enter a word with length: #{String.length(word)}")
    end

    if opts[:lives] do
      IO.puts("You have #{lives} lives left")
    end

    guess = get_valid_input("W Guess: ", &valid_input?(word, &1, guess_list))

    if guess != "stop" do
      cond do
        guess == word ->
          IO.puts("You win!")

        lives == 1 ->
          IO.puts("You lose! The word was #{word}")

        true ->
          IO.puts(Enum.join(feedback(word, guess), " "))
          play(word: word, guess_list: guess_list, lives: lives - 1)
      end
    end
  end

  @doc """
  Calculates the feedback for a guess.
  """
  def feedback(word, guess) do
    word = String.graphemes(word)
    guess = String.graphemes(guess)

    char_counts = Enum.frequencies(word)

    map_decr = fn map, k -> Map.update(map, k, 0, &(&1 - 1)) end

    unmatched_char_counts =
      Enum.zip(word, guess)
      |> Enum.reduce(char_counts, fn {w, g}, acc ->
        if w == g, do: map_decr.(acc, g), else: acc
      end)

    {_, result} =
      Enum.zip_reduce(word, guess, {unmatched_char_counts, []}, fn w, g, {rem_chars, result} ->
        cond do
          w == g ->
            {rem_chars, [:green | result]}

          Map.get(rem_chars, g, 0) > 0 ->
            {map_decr.(rem_chars, g), [:yellow | result]}

          true ->
            {rem_chars, [:gray | result]}
        end
      end)

    Enum.reverse(result)
  end

  defp valid_input?(word, guess, guess_list) do
    cond do
      String.match?(guess, ~r/\W/) ->
        IO.puts("Invalid guess, must be letters only")
        false

      String.length(guess) != String.length(word) ->
        IO.puts("Invalid guess length, must be #{String.length(word)}")
        false

      !Enum.member?(guess_list, guess) ->
        IO.puts("Invalid guess, not in list")
        false

      true ->
        true
    end
  end
end
