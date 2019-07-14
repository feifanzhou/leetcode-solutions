defmodule LeetcodeSolutionsWeb.ProblemsController do
  use LeetcodeSolutionsWeb, :controller
  alias LeetcodeSolutionsWeb.ProblemsList, as: ProblemsList

  def index(conn, _params) do
    case File.read(Path.relative_to_cwd("../problems/README.md")) do
      {:ok, markdown} -> render(conn, "index.html", title: "Problems", markdown: markdown, problems: ProblemsList.list())
      {:error, reason} -> text(conn, "Error reading problems readme: " <> Atom.to_string(reason))
    end
  end

  def show(conn, %{"id" => id}) do
    with folder_name <- problem_for_id(id).folder_name,
         folder_path = Path.relative_to_cwd(Path.join("../problems", folder_name)),
         {:ok, markdown} <-
           LeetcodeSolutionsWeb.MarkdownCat.preprocess_markdown(folder_path, "README.md") do
      render(conn, "show.html", title: id, markdown: markdown)
    else
      {:error, reason} ->
        text(conn, "Error reading readme for " <> id <> ": " <> Atom.to_string(reason))
    end
  end

  defp problem_for_id(id) do
    if String.match?(id, ~r/^\d+$/) do
      ProblemsList.from_number(id)
    else
      ProblemsList.from_slug(id)
    end
  end
end
