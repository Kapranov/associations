defmodule AssociationsWeb.TagView do
  use AssociationsWeb, :view

  attributes [:name]

  def type(_tag, _conn), do: "tags"
end
