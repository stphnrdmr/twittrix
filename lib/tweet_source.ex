alias Experimental.GenStage

defmodule Twittrix.TweetSource do
  use GenStage

  def start_link(query) do
    IO.puts "track: #{query}"
    GenStage.start_link(__MODULE__, query, name: __MODULE__)
  end

  def init(query) do
    {:producer, query}
  end

  def handle_demand(demand, query) when demand > 0 do
    IO.puts "DEMANDED: #{demand}"
    IO.puts "FETCHING 100"
    result = twitter_search(query, 100)
    {:noreply, result, query}
  end

  defp twitter_search(query, count) do
    {:ok, %{"statuses" => result}} = Twittex.Client.search(query, count: count)
    result
  end
end
