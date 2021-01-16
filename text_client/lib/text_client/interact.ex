defmodule TextClient.Interact do
  @hangman_server :hangman@fluke

  # alias TextClient.Player
  # alias TextClient.State
  # aliases can be combined
  alias TextClient.{Player, State}

  def start() do
    new_game()
    |> setup_state(:human)
    # |> IO.inspect(label: "Initial State")
    |> Player.play()
  end

  def start_ai() do
    new_game()
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

  defp new_game() do
    Node.connect(@hangman_server)

    :rpc.call(
      @hangman_server,
      # eplxicit
      # :"Elixir.Hangman"
      Hangman,
      :new_game,
      []
    )
  end

  # def play(state) do
  #   play(state)
  # end
end
