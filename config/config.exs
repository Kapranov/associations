use Mix.Config

config :associations,
  ecto_repos: [Associations.Repo]

config :associations, AssociationsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LIiSgWxZj5NkCPcbYdFo7WygIZV4VbER7aJkZ/FwMTn9TlKQYQS/cZjCSVVc0YPk",
  render_errors: [view: AssociationsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Associations.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
