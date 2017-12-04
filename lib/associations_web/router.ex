defmodule AssociationsWeb.Router do
  use AssociationsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AssociationsWeb do
    pipe_through :api
  end
end
