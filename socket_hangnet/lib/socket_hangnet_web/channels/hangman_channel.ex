defmodule SocketHangnetWeb.HangmanChannel do
  require Logger
  use Phoenix.Channel

  def join(_topic = "hangman:game", _args, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    { :ok, socket }
  end

  def handle_in("tally", _args, socket) do
    game = socket.assigns.game
    tally = Hangman.tally(game)
    # tally = %{msg: "no_tally_yet"}
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in("make_move", guess, socket) do
    tally = socket.assigns.game |> Hangman.make_move(guess)
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in("new_game", _, socket) do
    socket = socket |> assign(:game, Hangman.new_game())
    handle_in("tally", nil, socket)
  end

  def handle_in(msg, _args, socket) do
    Logger.error("Client message '#{msg}' is not handled.")
    { :noreply, socket }
  end
end
