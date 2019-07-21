defmodule LeetcodeSolutionsWeb.ProblemsController do
  use LeetcodeSolutionsWeb, :controller
  alias LeetcodeSolutionsWeb.ProblemsList, as: ProblemsList

  def index(conn, _params) do
    case File.read(Path.relative_to_cwd("problems/README.md")) do
      {:ok, markdown} ->
        render(conn, "index.html",
          title: "Problems",
          markdown: markdown,
          problems: ProblemsList.list()
        )

      {:error, reason} ->
        text(conn, "Error reading problems readme: " <> Atom.to_string(reason))
    end
  end

  def show(conn, %{"id" => id}) do
    with problem when not is_nil(problem) <- problem_for_id(id),
         folder_name <- problem.folder_name,
         folder_path = Path.relative_to_cwd(Path.join("problems", folder_name)),
         {:ok, markdown} <-
           LeetcodeSolutionsWeb.MarkdownCat.preprocess_markdown(folder_path, "README.md"),
         title <- problem.name <> " (#" <> Integer.to_string(problem.number) <> ")" do
      render(conn, "show.html", slug: problem.slug, description: "Hand-crafted solutions and explanations for the #{problem.name} problem on Leetcode.", title: title, markdown: markdown)
    else
      {:error, reason} ->
        text(conn, "Error reading readme for " <> id <> ": " <> Atom.to_string(reason))

      nil ->
        render(conn, "request.html", title: "Request a Solution", id: id)
    end
  end

  def request(conn, %{"id" => id, "email" => email}) do
    LeetcodeSolutionsWeb.Emails.request_solution(id, email) |> LeetcodeSolutionsWeb.Mailer.deliver_now()

    conn
    |> put_flash(:request_success, "Your request has been noted!")
    |> redirect(to: Routes.problems_path(conn, :show, id))
  end

  defp problem_for_id(id) do
    if String.match?(id, ~r/^\d+$/) do
      ProblemsList.from_number(id)
    else
      ProblemsList.from_slug(id)
    end
  end
end
