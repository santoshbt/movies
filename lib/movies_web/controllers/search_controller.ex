defmodule MoviesWeb.SearchController do
  use MoviesWeb, :controller
  alias Movies.Watchlist
  import MoviesWeb.Controllers.Helpers.CurrentUserHelper

  plug MoviesWeb.Plugs.AuthenticateUser when action in [:index]

  def index(conn, _params) do
    if current_user(conn) do
      query_param = conn.query_params["query"]
      response = Watchlist.search(query_param)
      results = response["results"]

      render(conn, "index.html",
        query: query_param,
        results: results,
        current_user: current_user(conn)
      )
    end
  end
end
