defmodule Twittrix.SerialSink do
  alias Experimental.GenStage
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    {:consumer, :ok, subscribe_to: [Twittrix.TweetProcessor]}
  end

  def handle_events(tweets, _from, state) do
    IO.inspect(tweets)
    {:noreplay, [], state}
  end
end
