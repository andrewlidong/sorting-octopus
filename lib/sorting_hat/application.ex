defmodule SortingHat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SortingHatWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:sorting_hat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SortingHat.PubSub},
      # Start a worker by calling: SortingHat.Worker.start_link(arg)
      # {SortingHat.Worker, arg},
      # Start to serve requests, typically the last entry
      SortingHatWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SortingHat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SortingHatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
