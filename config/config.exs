# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :leetcode_solutions,
  ecto_repos: [LeetcodeSolutions.Repo]

config :leetcode_solutions, LeetcodeSolutionsWeb.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.sendgrid.com",
  port: 587,
  username: "apikey",
  password: {:system, "SENDGRID_PASSWORD"},
  tls: :if_available,
  ssl: false,
  retries: 5

# Configures the endpoint
config :leetcode_solutions, LeetcodeSolutionsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jmZ7KSad/n1QWa1BTHgyBoSMYJkITrBZjM1QFRrvUjphFhG/vdc7iBYXAnc0d9+m",
  render_errors: [view: LeetcodeSolutionsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LeetcodeSolutions.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
