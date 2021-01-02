defmodule Fibonacci do
  # def fib(0), do: 0
  # def fib(1), do: 1

  # def fib(n) do
  #   agent = FibCache.start()
  #   result = fib(agent, n)
  #   Agent.stop(agent)
  #   result
  # end

  def fib(n) do
    # fib(n - 1) + fib(n - 2)
    case Cache.try_get(n) do
      {_cache_hit = true, cache_value} ->
        cache_value

      {_cache_hit = false, _} ->
        value = fib(n - 1) + fib(n - 2)
        Cache.set(n, value)
        value
    end
  end
end
