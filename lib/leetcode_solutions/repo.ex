defmodule LeetcodeSolutions.Repo do
  use Ecto.Repo,
    otp_app: :leetcode_solutions,
    adapter: Ecto.Adapters.Postgres
end
