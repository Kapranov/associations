defmodule AssociationsWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(AssociationsWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(AssociationsWeb.Gettext, "errors", msg, opts)
    end
  end
end
