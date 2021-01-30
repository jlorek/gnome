defmodule HangnetWeb.HangmanController do
  use HangnetWeb, :controller

  def new_game(conn, _params) do
    render(conn, "new_game.html")
  end

  def create_game(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    conn
    |> put_session(:game, game)
    |> render("game_field.html", tally: tally)
  end

  def make_move(conn, params) do
    # raise inspect params
    guess = params["make_move_data"]["guess"]
    tally = conn
      |> get_session(:game)
      |> Hangman.make_move(guess)

    put_in(conn.params["make_move_data"]["guess"], "")
    |> render("game_field.html", tally: tally)
  end
end
