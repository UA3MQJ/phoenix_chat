defmodule Chat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    Chat.Metrics.PrometheusExporter.setup()
    Chat.Metrics.ChatWSConnectsCount.setup()
    # Chat.Metrics.EndpointInstrumenter.setup()

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Chat.Repo,
      # Start the endpoint when the application starts
      ChatWeb.Endpoint,
      # Starts a worker by calling: Chat.Worker.start_link(arg)
      # {Chat.Worker, arg},
      supervisor(Chat.Presence, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
