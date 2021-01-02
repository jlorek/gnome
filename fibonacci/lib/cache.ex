defmodule Cache do
  @me __MODULE__

  def start() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end, name: @me)
  end

  def set(key, value) do
    Agent.update(@me, fn state -> Map.put(state, key, value) end)
    {true, value}
  end

  def try_get(key) do
    value = Agent.get(@me, fn state -> state[key] end)
    {is_integer(value), value}
  end
end
