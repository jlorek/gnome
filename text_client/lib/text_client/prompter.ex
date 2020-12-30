defmodule TextClient.Prompter do
  alias TextClient.State

  def accept_move(game = %State{player: :human}) do
    IO.gets("Your guess: ")
    |> check_input(game)
  end

  def accept_move(game = %State{player: :ai}) do
    [Enum.random(97..122)]
    |> List.to_string()
    |> check_input(game)
  end

  defp check_input({:error, reason}, _) do
    IO.puts("You broke the game 🥴")
    exit(:normal)
  end

  defp check_input({:eof}, _) do
    IO.puts("Looks like you gave up...")
    exit(:normal)
  end

  defp check_input(input, game = %State{}) do
    input = String.trim(input)

    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)

      # input =~ ~r/^[a-z]$/ ->
      # %{ game | guess: input }
      true ->
        IO.puts("Please enter a single lowercase letter")
        accept_move(game)
    end
  end
end
