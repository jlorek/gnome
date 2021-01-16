defmodule Hangman do
  def new_game() do
    {:ok, pid} = Supervisor.start_child(Hangman.Supervisor, [])
    count = Hangman.Stats.inc_count()
    IO.puts("There are #{count} games running.")
    pid
  end

  def make_move(game_pid, guess) do
    GenServer.call(game_pid, {:make_move, guess})
  end

  def tally(game_pid) do
    GenServer.call(game_pid, {:tally})
  end
end
