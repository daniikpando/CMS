defmodule CmsWeb.Router do
  use CmsWeb, :router

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

  scope "/", CmsWeb do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController
    resources "/articles", ArticleController
    get "/", PageController, :index
  end
end
