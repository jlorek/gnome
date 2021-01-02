defmodule Fibonacci.Application do
  use Application

  def start(_type, _args) do
    Cache.start()
  end
end
