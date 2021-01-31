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

  def handle_in(msg, _args, socket) do
    Logger.error("Client message '#{msg}' is not handled.")
    { :noreply, socket }
  end
end
