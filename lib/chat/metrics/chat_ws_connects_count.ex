defmodule Chat.Metrics.ChatWSConnectsCount do
  use Prometheus.Metric
  require Logger

  def setup do
    spec = [name: :chat_ws_connects_count, help: "Count of websocket connects"]
    Gauge.new(spec)
  end

  def inc() do
    Gauge.inc([name: :chat_ws_connects_count])
  end

  def dec() do
    Gauge.dec([name: :chat_ws_connects_count])
  end

end
