defmodule AssociationsWeb.Router do
  use AssociationsWeb, :router

  pipeline :api do
    plug :cors
    plug :accepts, ["json-api", "json"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
    plug :put_resp_content_type, MIME.type("json")
    plug :my_handler
  end

  scope "/api", AssociationsWeb do
    pipe_through :api

    get "/", PostController, :index

    resources "/posts", PostController, except: [:new, :edit]
    resources "/comments", CommentController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit]
  end

  def cors(conn, _opts) do
    conn
    |> put_resp_header("Access-Control-Allow-Origin", "*")
    |> put_resp_header("Access-Control-Allow-Headers", "Content-Type")
    |> put_resp_header("Access-Control-Allow-Methods", "GET,PUT,PATCH,DELETE,POST")
  end

  def my_handler(conn, _opts) do
    Plug.Conn.register_before_send(conn, fn conn ->
      IO.puts "/== START GENERATED RESPONSE =="
      IO.puts conn.resp_body
      IO.puts "\\==  END GENERATED RESPONSE  =="
      conn
    end)
  end
end
