defmodule HangnetWeb.HangmanView do
  use HangnetWeb, :view
  import HangnetWeb.Views.Helpers.GameStateHelper

  defp join_letters(letters) do
    Enum.join(letters, " ")
  end

  defp new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  defp game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end

  defp turn(left, target) when left > target, do: :faint
  defp turn(_left, _target), do: :opaque
end
