defmodule Associations.Repo.Seeds.Comments do
  alias FakerElixir, as: Faker
  alias Associations.Repo
  alias Associations.Blogs.{Comment}

  def seed do
    Repo.delete_all Comment

    posts = 1..3

    for _ <- 1..3 do
      params = %{
        body: Faker.Lorem.words(2..4),
        post_id: Enum.random(posts)
      }
      Repo.insert! Comment.changeset(%Comment{}, params)
    end
  end
end
