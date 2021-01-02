defmodule Fibonacci do
  # def fib(0), do: 0
  # def fib(1), do: 1

  def fib(n) do
    agent = FibCache.start()
    result = fib(agent, n)
    Agent.stop(agent)
    result
  end

  defp fib(agent, n) do
    # fib(n - 1) + fib(n - 2)
    case FibCache.try_get(agent, n) do
      {_cache_hit = true, cache_value} ->
        cache_value

      {_cache_hit = false, _} ->
        value = fib(agent, n - 1) + fib(agent, n - 2)
        FibCache.update(agent, {n, value})
        value
    end
  end
end
