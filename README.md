# Associations in the Phoenix

Associations are implemented using macro-style calls, so that you can
declaratively add features to your models.

## Ecto

`Ecto 2.0` by using the new `cast_assoc` and `cast_embed` APIs.

Associations in Ecto are used when two different sources (tables) are
linked via foreign keys.

A classic example of this setup is *Post has many comments* First create
the two tables in migrations:

```elixir
# priv/repo/migrations/20171204103713_create_posts.exs
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
```

```elixir
# priv/repo/migrations/20171204103724_create_comments.exs
defmodule Associations.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      # add :post_id, references(:posts, on_delete: :nothing)
      add :post_id, references(:posts, on_delete: :delete_all, type: :id)

      timestamps()
    end

    create index(:comments, [:post_id])
  end
end
```

```elixir
# priv/repo/migrations/20171204103736_create_tags.exs
defmodule Associations.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string

      timestamps()
    end

  end
end
```

Each comment contains a `post_id` column that by default points to a
post `id`. And now define the schemas:

```elixir
# lib/associations/blogs/post.ex
defmodule Associations.Blogs.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Associations.Blogs.Post


  schema "posts" do
    field :body, :string
    field :is_published, :boolean, default: false
    field :title, :string
    field :views, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :body, :views, :is_published])
    |> validate_required([:title, :body, :views, :is_published])
  end
end
```

```elixir
# lib/associations/blogs/comment.ex
defmodule Associations.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Associations.Blogs.Comment


  schema "comments" do
    field :body, :string
    # field :post_id, :id
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
```

```elixir
# lib/associations/blogs/tag.ex
defmodule Associations.Blogs.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Associations.Blogs.Tag


  schema "tags" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
```

## The `belongs_to` Association

A `belongs_to` association sets up a one-to-one connection with another
model, such that each instance of the declaring model "belongs to" one
instance of the other model.

## The Types of Associations

The Phoenix supports six types associations:

* `belongs_to`
* `has_one`
* `has_many`
* `has_many :through`
* `has_one :through`
* `has_and_belongs_to_many`

## Start an examples

Create App: `mix phx.new --no-brunch --no-html associations`

Create DBs: `mix ecto.create`

Create Resources `Posts/Comments/Tags`:

```elixir
mix phx.gen.json Blogs Post posts title:string body:text views:integer is_published:boolean
mix phx.gen.json Blogs Comment comments body:text post_id:references:posts
mix phx.gen.json Blogs Tag tags name:string
```

After modifications the schema: `mix ecto.migrate`

Start server for check it out: `mix phx.server`

```bash
http :4000/api          # {"data": [],"jsonapi":{"version": "1.0"}}
http :4000/api/posts    # {"data": [],"jsonapi":{"version": "1.0"}}
http :4000/api/comments # {"data": [],"jsonapi":{"version": "1.0"}}
http :4000/api/tags     # {"data": [],"jsonapi":{"version": "1.0"}}
```

Create seeds for models: `mix run priv/repo/seeds.exs`

Check it out GET/POST/PUT/DELETE/ requests:

**root `/api` path:**

```bash
curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      -X GET http://localhost:4000/api
```


**`Posts` table:**

```bash
curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      -X GET http://localhost:4000/api/posts

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      -X GET http://localhost:4000/api/posts/3

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      --data '{"data":{"type":"post","attributes":{"title":"testing"}}}' \
      -X PUT http://localhost:4000/api/posts/3

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      --data '{"data":{"type":"post","attributes":{"views":0,"title":"demo","is_published":false,"body":"testing"}}}' \
      -X POST http://localhost:4000/api/posts

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      -X DELETE http://localhost:4000/api/posts/4
```

**`Comments` table:**

```bash
curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      -X GET http://localhost:4000/api/comments

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      --data '{"data":{"type":"comment","attributes":{"body":"testing"}}}' \
      -X PUT http://localhost:4000/api/comments/3

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      --data '{"data":{"type":"comment","attributes":{"post_id": 1, "body":"testing"}}}' \
      -X POST http://localhost:4000/api/comments

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      -X DELETE http://localhost:4000/api/comments/4
```

**`Tags` table:**

```bash
curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      -X GET http://localhost:4000/api/tags

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      --data '{"data":{"type":"tag","attributes":{"name":"Joe Scarborought"}}}' \
      -X PUT http://localhost:4000/api/tags/3

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      --data '{"data":{"type":"tag","attributes":{"name":"Donny Deutsch"}}}' \
      -X POST http://localhost:4000/api/tags

curl  --header "Content-Type: application/vnd.api+json" \
      --header "Accept: application/vnd.api+json" \
      -X DELETE http://localhost:4000/api/tags/4
```

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

### 2017 Dec by Oleg G.Kapranov
