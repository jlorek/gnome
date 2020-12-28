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
    assert ^game = Game.make_move(game, "x")
  end

  test "state isn't changed for :lost game" do
    game = Game.new_game() |> Map.put(:game_state, :lost)
    assert ^game = Game.make_move(game, "x")
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letters is already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    game = Game.new_game("w")
    game = Game.make_move(game, "a")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    game = Game.make_move(game, "b")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5
    game = Game.make_move(game, "c")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4
    game = Game.make_move(game, "d")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3
    game = Game.make_move(game, "e")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2
    game = Game.make_move(game, "f")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1
    game = Game.make_move(game, "g")
    assert game.game_state == :lost
    assert game.turns_left == 0
  end

  test "another test" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")

    # wont work, because the new state only exists
    # in the inner scope until the end of the function
    # for each loop, the game will have its initial value
    # from the outside / above scope
    # for {guess, state} <- moves do
    #   IO.inspect(guess)
    #   IO.inspect(state)
    #   IO.inspect(game)
    #   game = Game.make_move(game, guess)
    #   #assert game.game_state == state
    # end

    moves
    |> Enum.reduce(game, fn {guess, state}, game ->
      game = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end)
  end
end
