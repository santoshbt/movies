defmodule MoviesWeb.MovieController do
  use MoviesWeb, :controller
  import MoviesWeb.Controllers.Helpers.CurrentUserHelper

  alias Movies.Watchlist
  alias Movies.Users.User
  plug MoviesWeb.Plugs.AuthenticateUser

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    movies = Watchlist.list_movies(current_user)
    render(conn, "index.html", movies: movies)
  end

  def show(conn, %{"id" => id}) do
    movie = Watchlist.get_movie!(id)
    render(conn, "show.html", movie: movie)
  end

  def watch_later(conn, %{"id" => id}) do
    case Watchlist.watch_movie(current_user(conn), id) do
      %User{} -> redirect_info(conn, :info, "Movie added to watchlist")
      {:error, _} -> redirect_info(conn, :error, "Something went wrong, please try again")
    end
  end

  def remove_watchlist(conn, %{"id" => id}) do
    case Watchlist.remove(current_user(conn), id) do
      {1, nil} ->
        redirect_info(conn, :info, "Movie removed from watchlist")

      {0, nil} ->
        redirect_info(conn, :error, "Moview not found in watchlist")
    end
  end

  defp redirect_info(conn, type, message) do
    conn
    |> put_flash(type, message)
    |> redirect(to: Routes.movie_path(conn, :index))
  end
end
