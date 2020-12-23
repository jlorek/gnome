defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert is_list(game.letters)
    assert length(game.letters) > 0
    assert Enum.all?(game.letters, fn letter -> is_lowercase_letter(letter) end)
    assert Enum.all?(game.letters, &is_lowercase_letter(&1))
  end

  def is_lowercase_letter(letter) do
    # letter =~ ~r/[a-z]/

    # https://elixirforum.com/t/how-to-check-if-a-unicode-codepoint-represents-a-letter-or-an-uppercase-letter/33632
    # letter == String.downcase(letter)

    # https://elixirforum.com/t/get-ascii-value-of-a-character/16619
    <<c::utf8>> = letter
    c in ?a..?z
  end

  def is_uppercase_letter(letter), do: letter =~ ~r/[A-Z]/

  test "state isn't changed for :won game" do
    game = Game.new_game() |> Map.put(:game_state, :won)
    assert {^game, _} = Game.make_move(game, "x")
  end

  test "state isn't changed for :lost game" do
    game = Game.new_game() |> Map.put(:game_state, :lost)
    assert {^game, _} = Game.make_move(game, "x")
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letters is already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end
end
