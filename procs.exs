defmodule Procs do
  # iex
  # c "procs.exs"
  # pid = spawn Procs, :greeter, [0]
  # send pid, "hello"
  # send pid {:add, 10}
  # send pid "world"

  def greeter(count) do
    receive do
      {:add, n} ->
        greeter(count + n)

      {:reset} ->
        greeter(0)

      {:boom, reason} ->
        exit(reason)

      msg ->
        IO.puts("#{count}: #{inspect(msg)}")
        greeter(count)
    end
  end
end
