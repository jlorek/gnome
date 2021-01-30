defmodule Hangman do
  def new_game() do
    IO.puts("Running on #{Node.self()}")
    {:ok, pid} = Supervisor.start_child(Hangman.Supervisor, [])
    count = Hangman.Stats.inc_count()
    IO.puts("Total served games: #{count}")
    clients = length(Node.list())
    IO.puts("Connected clients: #{clients}")
    pid
  end

  def make_move(game_pid, guess) do
    GenServer.call(game_pid, {:make_move, guess})
  end

  def tally(game_pid) do
    GenServer.call(game_pid, {:tally})
  end
end
