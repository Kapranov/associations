use Mix.Config

config :associations,
  ecto_repos: [Associations.Repo]

config :associations, AssociationsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LIiSgWxZj5NkCPcbYdFo7WygIZV4VbER7aJkZ/FwMTn9TlKQYQS/cZjCSVVc0YPk",
  render_errors: [view: AssociationsWeb.ErrorView, accepts: ~w(json json-api)],
  pubsub: [name: Associations.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :associations, :generators,
  migration: true,
  binary_id: false

config :cors_plug,
  origin: "http://localhost:4000",
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS", "HEAD"]

config :phoenix, :format_encoders,
  "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :ja_serializer,
  key_format: :underscored

import_config "#{Mix.env}.exs"
