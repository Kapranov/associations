defmodule Associations.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Associations.Blogs.Comment


  schema "comments" do
    field :body, :string
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
