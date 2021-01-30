defmodule HangnetWeb.Views.Helpers.GameStateHelper do
  import Phoenix.HTML, only: [ raw: 1 ]

  @responses %{
    :won => {:info, "You won! 🎉" },
    :lost => {:danger, "You lost... 😯" },
    :good_guess => {:info, "Good guess! 🤓" },
    :bad_guess => {:warning, "Bad guess! 😦" },
    :invalid_guess => {:danger, "Invalid guess 🥴" },
    :already_used => {:info, "You already guessed that 😉" },
  }

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert(nil), do: ""

  defp alert({class, message}) do
    """
    <div class="alert alert-#{class}">
      #{message}
    </div>
    """
    |> raw()
  end
end
