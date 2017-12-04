defmodule AssociationsWeb.TagController do
  use AssociationsWeb, :controller

  alias Associations.Blogs
  alias Associations.Blogs.Tag

  action_fallback AssociationsWeb.FallbackController

  def index(conn, _params) do
    tags = Blogs.list_tags()
    render(conn, "index.json-api", data: tags)
  end

  def create(conn, %{"data" => %{"attributes" => tag_params}}) do
    with {:ok, %Tag{} = tag} <- Blogs.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tag_path(conn, :show, tag))
      |> render("show.json-api", data: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Blogs.get_tag!(id)
    render(conn, "show.json-api", data: tag)
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => tag_params}}) do
    tag = Blogs.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Blogs.update_tag(tag, tag_params) do
      render(conn, "show.json-api", data: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Blogs.get_tag!(id)
    with {:ok, %Tag{}} <- Blogs.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
