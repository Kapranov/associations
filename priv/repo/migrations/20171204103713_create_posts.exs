defmodule Associations.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :views, :integer, default: 0
      add :is_published, :boolean, default: false, null: false

      timestamps()
    end

  end
end
