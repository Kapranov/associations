defmodule Associations.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Associations.Blogs.Comment


  schema "comments" do
    field :body, :string
    belongs_to :post, Associations.Blogs.Post

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:body, :post_id])
    |> validate_required([:body])
  end
end
