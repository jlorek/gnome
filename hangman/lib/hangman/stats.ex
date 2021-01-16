defmodule Hangman.Stats do
  use GenServer

  def start() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_init_args) do
    {:ok, %{count: 0}}
  end

  def handle_call({:inc_count}, _from, state) do
    new_count = state.count + 1
    {:reply, new_count, %{state | count: new_count}}
  end

  def inc_count() do
    # because __MODULE__ was used as name in start/0
    GenServer.call(__MODULE__, {:inc_count})
  end
end
