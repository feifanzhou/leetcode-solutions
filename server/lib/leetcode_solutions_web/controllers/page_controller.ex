defmodule LeetcodeSolutionsWeb.PageController do
  use LeetcodeSolutionsWeb, :controller

  def index(conn, _params) do
    case File.read(Path.relative_to_cwd("../README.md")) do
      {:ok, markdown} -> html(conn, Earmark.as_html!(markdown))
      {:error, reason} -> text(conn, "Error reading root readme: " <> Atom.to_string(reason))
    end
  end
end
