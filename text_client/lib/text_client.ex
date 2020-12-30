defmodule TextClient do
  defdelegate start(), to: TextClient.Interact
  defdelegate start_ai(), to: TextClient.Interact
end
