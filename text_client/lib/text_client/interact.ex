defmodule TextClient.Interact do
  # alias TextClient.Player
  # alias TextClient.State
  alias TextClient.{Player, State}

  def start() do
    Hangman.new_game()
    |> setup_state(:human)
    # |> IO.inspect(label: "Initial State")
    |> Player.play()
  end

  def start_ai() do
    Hangman.new_game()
    |> setup_state(:ai)
    |> Player.play()
  end

  defp setup_state(game, player) when player in [:human, :ai] do
    %State{
      game_service: game,
      tally: Hangman.tally(game),
      player: player
    }
  end

  def play(state) do
    play(state)
  end
end
