defmodule Twittrix do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Nerves.UART, [[{:name, :UART}]]),
      worker(Twittrix.TweetSource, [Application.get_env(:twittrix, :hashtag)]),
      worker(Twittrix.TextExtractor, []),
      worker(Twittrix.SerialSink, [])
    ]

    opts = [strategy: :one_for_one, name: Twittrix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
