defmodule Associations.Blogs.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Associations.Blogs.Post


  schema "posts" do
    field :body, :string
    field :is_published, :boolean, default: false
    field :title, :string
    field :views, :integer

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body, :views, :is_published])
    |> validate_required([:title, :body, :views, :is_published])
  end
end
