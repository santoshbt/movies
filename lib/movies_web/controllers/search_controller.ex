defmodule MoviesWeb.SearchController do
  use MoviesWeb, :controller
  alias Movies.Watchlist

  plug MoviesWeb.Plugs.AuthenticateUser when action in [:index]
  use MoviesWeb.CurrentUserController

  def index(conn, _params, current_user) do
    query_param = conn.query_params["query"]
    response = Watchlist.search(query_param)
    results = response["results"]

    render(conn, "index.html",
      query: query_param,
      results: results,
      current_user: current_user
    )
  end
end
