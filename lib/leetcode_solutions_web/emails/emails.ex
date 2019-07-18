defmodule LeetcodeSolutionsWeb.Emails do
  use Bamboo.Phoenix, view: LeetcodeSolutionsWeb.EmailView

  def request_solution(id, contact_at) do
    new_email()
    |> to(System.get_env("ADMIN_EMAIL"))
    |> from("Leetcode Solutions <server@leetcodesolutions.com>")
    |> subject("Solution request")
    |> text_body("Requested: " <> id <> ", Contact: " <> contact_at)
  end
end
