# Associations in the Phoenix

Associations are implemented using macro-style calls, so that you can
declaratively add features to your models.

Associations in Ecto are used when two different sources (tables) are
linked via foreign keys.

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
