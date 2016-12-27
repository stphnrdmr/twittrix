defmodule Twittrix.TweetProcessor do
  alias Experimental.GenStage
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer_consumer, :ok}
  end
end
