defmodule LeetcodeSolutionsWeb.MarkdownCat do
  def preprocess_markdown(folder_path, md_filename) do
    filepath = Path.join(folder_path, md_filename)

    with {:ok, markdown} <- File.read(filepath),
         catted_markdown =
           String.replace(markdown, ~r/@cat ([a-z0-9-_\.]+)/, fn match ->
             filename = match |> String.split("@cat ") |> Enum.at(1)

             case File.read(Path.join(folder_path, filename)) do
               {:ok, content} -> cat_ignore(content)
               {:error, e} -> "Error catting " <> filename <> ": " <> Atom.to_string(e)
             end
           end) do
      {:ok, catted_markdown}
    else
      e -> e
    end
  end

  defp cat_ignore(content) do
    content
    |> String.split("\n")
    |> Enum.reject(fn line -> line |> String.ends_with?("@CAT_IGNORE") end)
    |> Enum.join("\n")
  end
end
