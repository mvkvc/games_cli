defmodule Games.Utils do
  @moduledoc """
  Utility functions for games.
  """
  def get_valid_input(prompt, valid_function) do
    guess = IO.gets(prompt) |> String.trim() |> String.downcase()

    cond do
      guess == "stop" || valid_function.(guess) -> guess
      true -> get_valid_input(prompt, valid_function)
    end
  end
end
