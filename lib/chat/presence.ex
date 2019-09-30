defmodule Chat.Presence do
  use Phoenix.Presence, otp_app: :chat,
                        pubsub_server: Chat.PubSub

  require Logger

  def fetch(topic, presences) do
    Logger.debug ">>>>>>>>>>>> fetch topic=#{inspect topic} presences=#{inspect presences}"
    # Chat.Metrics.ChatWSConnectsCount.update_metrics()
  end

end