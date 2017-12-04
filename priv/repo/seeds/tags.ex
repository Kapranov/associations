defmodule Associations.Repo.Seeds.Tags do
  alias FakerElixir, as: Faker
  alias Associations.Repo
  alias Associations.Blogs.{Tag}

  def seed do
    Repo.delete_all Tag

    for _ <- 1..9 do
      params = %{
        name: Faker.Name.name,
      }
      Repo.insert! Tag.changeset(%Tag{}, params)
    end
  end
end
