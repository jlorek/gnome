defmodule Fibonacci do
  # def fib(0), do: 0
  # def fib(1), do: 1

  def fib(agent, n) do
    # fib(n - 1) + fib(n - 2)
    {cache_hit, cache_value} = FibCache.try_get(agent, n)

    cond do
      cache_hit == true ->
        cache_value

      cache_hit == false ->
        value = fib(agent, n - 1) + fib(agent, n - 2)
        FibCache.update(agent, {n, value})
        value
    end
  end
end
