defmodule LeetcodeSolutionsWeb.Problem do
  defstruct name: "", slug: "", number: 0, folder_name: ""
end

defmodule LeetcodeSolutionsWeb.ProblemsList do
  defmodule MemoizedList do
    # http://rocket-science.ru/hacking/2017/11/23/idiomatic-function-memoization-in-elixir
    use GenServer

    def start_link(_opts \\ []) do
      GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end

    def init(_args) do
      problems_list = list_problems_from_filesystem() |> Enum.sort_by(fn p -> p.number end)
      number_lookup = problems_list |> Enum.map(fn p -> {p.number, p} end) |> Map.new()
      slug_lookup = problems_list |> Enum.map(fn p -> {p.slug, p} end) |> Map.new()
      {:ok, %{list: problems_list, by_number: number_lookup, by_slug: slug_lookup}}
    end

    def value() do
      start_link()
      GenServer.call(__MODULE__, :value)
    end

    def handle_call(:value, _from, state) do
      {:reply, state, state}
    end

    defp list_problems_from_filesystem() do
      with {:ok, ls} <- File.ls(Path.relative_to_cwd("../problems")) do
        regex = ~r/^(\d{4})-([A-Za-z0-9-_.]+)$/

        ls
        |> Enum.map(fn f -> captured_folder_name_to_problem(Regex.run(regex, f)) end)
        |> Enum.reject(&is_nil/1)
      else
        []
      end
    end

    defp captured_folder_name_to_problem(regex_captures) do
      with [full_string, padded_number, slug] <- regex_captures,
           {number, _} <- Integer.parse(padded_number) do
        %LeetcodeSolutionsWeb.Problem{
          name: Recase.to_title(slug),
          slug: slug,
          number: number,
          folder_name: full_string
        }
      else
        _ -> nil
      end
    end
  end

  def list() do
    MemoizedList.value().list
  end

  def from_number(number) when is_integer(number) do
    MemoizedList.value().by_number[number]
  end

  def from_number(number) when is_binary(number) do
    {int, _} = Integer.parse(number)
    MemoizedList.value().by_number[int]
  end

  def from_slug(slug) do
    MemoizedList.value().by_slug[slug]
  end
end
