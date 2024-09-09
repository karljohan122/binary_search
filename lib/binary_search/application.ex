defmodule BinarySearch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BinarySearchWeb.Telemetry,
      BinarySearch.Repo,
      {DNSCluster, query: Application.get_env(:binary_search, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BinarySearch.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BinarySearch.Finch},
      # Start a worker by calling: BinarySearch.Worker.start_link(arg)
      # {BinarySearch.Worker, arg},
      # Start to serve requests, typically the last entry
      BinarySearchWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BinarySearch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BinarySearchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
