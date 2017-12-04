use Mix.Config

config :associations, AssociationsWeb.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

config :associations, Associations.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "associations_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
