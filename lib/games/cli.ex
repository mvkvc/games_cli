defmodule Games.CLI do
  @moduledoc """
  CLI is the command line interface for the games library.
  """

  @doc """
  Start the CLI.
  """
  def start(_, _) do
    #    args = Burrito.Util.Args.get_arguments() # If arguments needed
    Games.Menu.display()
  end
end
