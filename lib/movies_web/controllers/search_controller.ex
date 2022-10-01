defmodule MoviesWeb.SearchController do
  use MoviesWeb, :controller
  alias Movies.Watchlist

  def index(conn, _params) do
    query_param = conn.query_params["query"]
    response = Watchlist.search(query_param)
    results = response["results"]

    render(conn, "index.html", query: query_param, results: results)
  end
end
