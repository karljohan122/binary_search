defmodule BinarySearch.Repo do
  use Ecto.Repo,
    otp_app: :binary_search,
    adapter: Ecto.Adapters.Postgres
end
