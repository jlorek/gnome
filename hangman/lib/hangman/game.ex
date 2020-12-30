defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints()
    }
  end

  def new_game() do
    Dictionary.random_word()
    |> new_game()
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used),
      used: game.used
    }
  end

  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    game
  end

  # def make_move(game = %{ game_state: :won }, _guess) do
  #   { game, tally(game) }
  # end

  # def make_move(game = %{ game_state: :lost}, _guess) do
  #   { game, tally(game) }
  # end

  def make_move(game, guess) do
    make_move(game, guess, guess =~ ~r/[a-z]/)
    # accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  ###################

  def make_move(game, guess, _is_valid_character = true) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
  end

  def make_move(game, _guess, _invalid_character) do
    Map.put(game, :game_state, :invalid_guess)
  end

  defp accept_move(game, _guess, _alread_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  defp accept_move(game, guess, _alread_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  defp score_guess(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won()

    Map.put(game, :game_state, new_state)
    # won?
    # won? -> :won, :good_guess
  end

  defp score_guess(game = %{turns_left: 1}, _not_good_guess) do
    # Map.put(game, :game_state, :lost)
    %{game | game_state: :lost, turns_left: 0}
  end

  defp score_guess(game = %{turns_left: turns_left}, _not_good_guess) do
    %{game | game_state: :bad_guess, turns_left: turns_left - 1}
  end

  defp maybe_won(true), do: :won
  defp maybe_won(false), do: :good_guess

  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true), do: letter
  defp reveal_letter(_letter, _in_word = false), do: "_"
end
