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
    send_text("hi")

    await_text("sup?\r\n")

    send_text(message <> <<0>>)
  end

  defp await_text(text, current \\ "") do
    {:ok, received} = Nerves.UART.read(:UART, 60000)
    combined = current <> received
    unless combined == text do
      await_text(text, combined)
    end
  end

  defp send_text(text) do
    :ok = Nerves.UART.write(:UART, text)
  end
end
