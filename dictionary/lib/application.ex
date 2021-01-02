defmodule Dictionary.Application do
  use Application

  def start(_type, _args) do
    # Dictionary.WordList.start_link()

    import Supervisor.Spec

    children = [
      worker(Dictionary.WordList, [])
    ]

    options = [
      name: Dictionary.Supervisor,
      strategy: :one_for_one,
      max_restarts: 2,
      max_seconds: 4
    ]

    Supervisor.start_link(children, options)
  end
end
