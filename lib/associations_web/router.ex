defmodule AssociationsWeb.Router do
  use AssociationsWeb, :router

  pipeline :api do
    plug :cors
    plug :accepts, ["json-api", "json"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", AssociationsWeb do
    pipe_through :api

    get "/", PageController, :index
  end

  def cors(conn, _opts) do
    conn
    |> put_resp_header("Access-Control-Allow-Origin", "*")
    |> put_resp_header("Access-Control-Allow-Headers", "Content-Type")
    |> put_resp_header("Access-Control-Allow-Methods", "GET,PUT,PATCH,OPTIONS,DELETE,POST")
  end
end
