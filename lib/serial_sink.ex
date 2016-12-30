defmodule Twittrix.SerialSink do
  alias Experimental.GenStage
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, [])
  end

  def init(tweets) do
    Nerves.UART.open(:UART, "/dev/cu.SLAB_USBtoUART", speed: 9600, active: false)
    {:consumer, tweets, subscribe_to: [{Twittrix.TextExtractor, max_demand: 1}]}
  end

  def handle_events(events, _from, _tweets) do
    set_grid_message(hd(events))

    {:noreply, [], nil}
  end

  defp set_grid_message(message) do
    IO.inspect [self,"awake"]

    send_text("hi")
    IO.inspect [self,"sent hi"]

    await_text("sup?\r\n")
    IO.inspect [self,"read sup"]

    send_text(message <> <<0>>)
    IO.inspect [self,"sent msg"]
    IO.puts "|#{message}|"
  end

  defp await_text(text, current \\ "") do
    {:ok, received} = Nerves.UART.read(:UART, 60000)
    IO.puts "#{received}"
    combined = current <> received
    unless combined == text do
      await_text(text, combined)
    end
  end

  defp send_text(text) do
    :ok = Nerves.UART.write(:UART, text)
  end
end
