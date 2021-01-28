defmodule Hangman.Server do
  use GenServer
  alias Hangman.Game

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_init_args) do
    {:ok, Game.new_game()}
  end

  def handle_call({:make_move, guess}, _from, game_state) do
    {game_state, tally} = Game.make_move(game_state, guess)
    # { :reply, response_to_caller, new_state }
    {:reply, tally, game_state}
  end

  def handle_call({:tally}, _from, game_state) do
    tally = Game.tally(game_state)
    {:reply, tally, game_state}
  end
end
