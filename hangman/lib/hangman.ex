defmodule Hangman do
  alias Hangman.Game

  def hello do
    IO.puts(Dictionary.random_word())
  end

  defdelegate new_game(), to: Game

  defdelegate init_game(), to: Game, as: :new_game
end
