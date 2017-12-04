defmodule AssociationsWeb.PostView do
  use AssociationsWeb, :view

  attributes [:title, :body, :views, :is_published]

  def type(_post, _conn), do: "posts"
end
