defmodule Twittrix.TextExtractor do
  alias Experimental.GenStage
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(tweets) do
    {:producer_consumer, tweets, subscribe_to: [{Twittrix.TweetSource, max_demand: 50}]}
  end

  def handle_events(events, _from, tweets) do
    IO.puts "RECEIVED: #{length(events)}"
    {:noreply, Enum.map(events, &(&1["text"])), tweets}
  end
end
