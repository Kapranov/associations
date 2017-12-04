defmodule AssociationsWeb.PostController do
  use AssociationsWeb, :controller

  alias Associations.Blogs
  alias Associations.Blogs.Post

  action_fallback AssociationsWeb.FallbackController

  def index(conn, _params) do
    posts = Blogs.list_posts()
    render(conn, "index.json-api", data: posts)
  end

  def create(conn, %{"data" => %{"attributes" => post_params}}) do
    with {:ok, %Post{} = post} <- Blogs.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json-api", data: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blogs.get_post!(id)
    render(conn, "show.json-api", data: post)
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => post_params}}) do
    post = Blogs.get_post!(id)

    with {:ok, %Post{} = post} <- Blogs.update_post(post, post_params) do
      render(conn, "show.json-api", data: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blogs.get_post!(id)
    with {:ok, %Post{}} <- Blogs.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
