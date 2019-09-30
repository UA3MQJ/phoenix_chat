defmodule ChatWeb.RoomChannel do
  use ChatWeb, :channel
  alias Chat.Presence
  require Logger

  def join("chat_room:lobby", payload, socket) do
    Chat.Metrics.ChatWSConnectsCount.inc()
    Process.flag(:trap_exit, true)
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("topic:subtopic", _payload, socket) do
    Chat.Metrics.ChatWSConnectsCount.inc()
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    Chat.Message.changeset(%Chat.Message{}, payload) |> Chat.Repo.insert 
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    Chat.Message.get_messages()
    |> Enum.each(fn msg -> push(socket, "shout", %{
        name: msg.name,
        message: msg.message,
      }) end)

    # pid_str = socket.transport_pid |> inspect() |> String.split("<") |> tl |> hd |> String.split(">") |> hd
    # {:ok, _} = Presence.track(socket, pid_str, %{online_at: inspect(System.system_time(:seconds))})

    # Chat.Metrics.ChatWSConnectsCount.update_metrics()

    {:noreply, socket} # :noreply
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  def terminate(reason, socket) do
    Logger.debug ">>>>> TERMINATE reason=#{inspect reason} socket=#{inspect socket}"

    Chat.Metrics.ChatWSConnectsCount.dec()

    reason
  end

end
