defmodule SortingHatWeb.Router do
  use SortingHatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SortingHatWeb do
    pipe_through :browser
    get "/", PageController, :index
    post "/sort", PageController, :sort
  end
end
