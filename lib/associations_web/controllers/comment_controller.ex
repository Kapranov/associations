defmodule AssociationsWeb.CommentController do
  use AssociationsWeb, :controller

  alias Associations.Blogs
  alias Associations.Blogs.Comment

  action_fallback AssociationsWeb.FallbackController

  def index(conn, _params) do
    comments = Blogs.list_comments()
    render(conn, "index.json-api", data: comments)
  end

  def create(conn, %{"data" => %{"attributes" => comment_params}}) do
    with {:ok, %Comment{} = comment} <- Blogs.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", comment_path(conn, :show, comment))
      |> render("show.json-api", data: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Blogs.get_comment!(id)
    render(conn, "show.json-api", data: comment)
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => comment_params}}) do
    comment = Blogs.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Blogs.update_comment(comment, comment_params) do
      render(conn, "show.json-api", data: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Blogs.get_comment!(id)
    with {:ok, %Comment{}} <- Blogs.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
