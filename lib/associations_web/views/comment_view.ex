defmodule AssociationsWeb.CommentView do
  use AssociationsWeb, :view

  attributes [:body, :post_id]

  def type(_comment, _conn), do: "comments"
end
