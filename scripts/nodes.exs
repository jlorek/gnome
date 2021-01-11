defmodule NodeDemo do
  def reverse do
    receive do
      {from_pid, msg} ->
        result = msg |> String.reverse()
        IO.inspect(from_pid)
        send(from_pid, result)
        reverse()

      msg ->
        result = msg |> String.reverse()
        IO.puts(result)
        reverse()
    end
  end
end
