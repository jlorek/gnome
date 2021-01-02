defmodule FibCache do
  def start() do
    {:ok, pid} = Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
    pid
  end

  def update(agent, {key, value}) do
    Agent.update(agent, fn state -> Map.put(state, key, value) end)
  end

  def try_get(agent, key) do
    value = Agent.get(agent, fn state -> state[key] end)
    {is_integer(value), value}
  end
end
