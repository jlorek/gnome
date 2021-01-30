defmodule Hangman.Stats do
  use GenServer

  def start() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_init_args) do
    :ok = :net_kernel.monitor_nodes(true)
    {:ok, %{count: 0}}
  end

  def handle_call({:inc_count}, _from, state) do
    new_count = state.count + 1
    {:reply, new_count, %{state | count: new_count}}
  end

  def handle_cast({:start_monitor}, state) do
    :ok = :net_kernel.monitor_nodes(true)
    {:noreply, state}
  end

  def handle_info({:nodeup, node}, state) do
    IO.puts("Node connected: #{inspect(node)}")
    {:noreply, state}
  end

  def handle_info({:nodedown, node}, state) do
    IO.puts("Node disconnected: #{inspect(node)}")
    {:noreply, state}
  end

  def inc_count() do
    # because __MODULE__ was used as name in start/0
    GenServer.call(__MODULE__, {:inc_count})
  end

  def start_monitor() do
    GenServer.cast(__MODULE__, {:start_monitor})
  end
end
