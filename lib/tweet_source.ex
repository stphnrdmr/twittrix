defmodule Twittrix.TweetSource do
  alias Experimental.GenStage
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer, :ok}
  end

  def handle_demand(demand, :ok) when demand > 0 do
    {:noreplay}
  end
end
