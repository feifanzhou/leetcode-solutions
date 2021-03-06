defmodule LeetcodeSolutionsWeb.Router do
  use LeetcodeSolutionsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LeetcodeSolutionsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/problems", ProblemsController, :index
    get "/problemset/all", ProblemsController, :index
    get "/problems/:id", ProblemsController, :show
    get "/request/:id", ProblemsController, :show
    post "/request/:id", ProblemsController, :request
  end

  # Other scopes may use custom stacks.
  # scope "/api", LeetcodeSolutionsWeb do
  #   pipe_through :api
  # end
end
