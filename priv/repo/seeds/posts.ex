defmodule Associations.Repo.Seeds.Posts do
  alias FakerElixir, as: Faker
  alias Associations.Repo
  alias Associations.Blogs.{Post}

  def seed do
    Repo.delete_all Post

    for _ <- 1..3 do
      params = %{
        title: Faker.Lorem.words(1),
        body: Faker.Lorem.words(2..4),
        views: :rand.uniform(3),
        published: Enum.random([true, false])
      }
      Repo.insert! Post.changeset(%Post{}, params)
    end
  end
end

