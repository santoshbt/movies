defmodule MoviesWeb.Router do
  use MoviesWeb, :router
  use Pow.Phoenix.Router
  # alias MoviesWeb.Router.Helpers, as: Routes

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MoviesWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug MoviesWeb.ApiAuthPlug, otp_app: :movies
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", MoviesWeb do
    pipe_through [:browser]

    get "/search", SearchController, :index
    resources "/", MovieController, only: [:index, :show]
  end

  scope "/movies", MoviesWeb do
    pipe_through [:browser]

    get "/watch_later/:id", MovieController, :watch_later
    get "/remove_watchlist/:id", MovieController, :remove_watchlist
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
