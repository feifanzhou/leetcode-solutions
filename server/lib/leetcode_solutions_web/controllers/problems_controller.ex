defmodule LeetcodeSolutionsWeb.ProblemsController do
  use LeetcodeSolutionsWeb, :controller

  def index(conn, _params) do
    case File.read(Path.relative_to_cwd("../problems/README.md")) do
      {:ok, markdown} -> render(conn, "index.html", markdown: markdown)
      {:error, reason} -> text(conn, "Error reading problems readme: " <> Atom.to_string(reason))
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, folder_name} <- folder_name_for_id(id),
         folder_path = Path.relative_to_cwd(Path.join("../problems", folder_name)),
         {:ok, markdown} <-
           LeetcodeSolutionsWeb.MarkdownCat.preprocess_markdown(folder_path, "README.md") do
      render(conn, "show.html", markdown: markdown)
    else
      {:error, reason} ->
        text(conn, "Error reading readme for " <> id <> ": " <> Atom.to_string(reason))
    end
  end

  defp folder_name_for_id(id) do
    with {:ok, ls} <- File.ls(Path.relative_to_cwd("../problems")),
         folder_name =
           (if String.match?(id, ~r/^\d+$/) do
              folder_name_for_number(ls, id)
            else
              folder_name_for_slug(ls, id)
            end) do
      case folder_name do
        nil -> {:error, :enoent}
        folder_name -> {:ok, folder_name}
      end
    else
      {:error, e} -> {:error, e}
    end
  end

  defp folder_name_for_number(ls, id_number) do
    padded_number = String.pad_leading(id_number, 4, "0")
    Enum.find(ls, fn l -> String.starts_with?(l, padded_number) end)
  end

  defp folder_name_for_slug(ls, id_slug) do
    Enum.find(ls, fn l -> String.ends_with?(l, id_slug) end)
  end
end
