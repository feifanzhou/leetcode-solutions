use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :leetcode_solutions, LeetcodeSolutionsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :leetcode_solutions, LeetcodeSolutions.Repo,
  username: "postgres",
  password: "postgres",
  database: "leetcode_solutions_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
