defmodule SocketHangnetWeb.HangmanChannel do
  require Logger
  use Phoenix.Channel

  def join(_topic = "hangman:game", _args, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    send(self(), {:tick, 0})
    { :ok, socket }
  end

  def handle_info({:tick, total_seconds}, socket) do
    game = socket.assigns.game
    unless Hangman.game_finished?(game) do
      Process.send_after(self(), {:tick, total_seconds + 1}, 1000)
    end
    push(socket, "timer", %{total_seconds: total_seconds})
    { :noreply, socket }
  end

  def handle_in("tally", _args, socket) do
    game = socket.assigns.game
    tally = Hangman.tally(game)
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
    send(self(), {:tick, 0})
    handle_in("tally", nil, socket)
  end

  def handle_in(msg, _args, socket) do
    Logger.error("Client message '#{msg}' is not handled.")
    { :noreply, socket }
  end
end
