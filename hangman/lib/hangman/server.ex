defmodule Hangman.Server do
  use GenServer
  alias Hangman.Game

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_init_args) do
    {:ok, Game.new_game()}
  end

  def handle_call({:make_move, guess}, _from, game) do
    {game, tally} = Game.make_move(game, guess)
    {:reply, tally, game}
  end

  def handle_call({:tally}, _from, game) do
    tally = Game.tally(game)
    {:reply, tally, game}
  end
end
