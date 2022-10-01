defmodule MoviesWeb.MovieController do
  use MoviesWeb, :controller
  import MoviesWeb.Helpers.CurrentUserHelper

  alias Movies.Watchlist
  alias Movies.Users.User
  # alias MoviesWeb.AuthErrorHandler

  def index(conn, _params) do
    movies = Watchlist.list_movies()
    render(conn, "index.html", movies: movies)
  end

  def show(conn, %{"id" => id}) do
    movie = Watchlist.get_movie!(id)
    render(conn, "show.html", movie: movie)
  end

  def watch_later(conn, %{"id" => id}) do
    if current_user(conn) do
      case Watchlist.watch_movie(current_user(conn), id) do
        %User{} -> redirect_info(conn, :info, "Movie added to watchlist")

        {:error, _} -> redirect_info(conn, :error, "Something went wrong, please try again")
      end
    else
      message = "Please login"
      conn
        |> put_flash(:error, message)
        |> redirect(to: Routes.pow_session_path(conn, :new)) |> halt()
    end
  end

  defp redirect_info(conn, type, message) do
    conn
      |> put_flash(type, message)
      |> redirect(to: Routes.page_path(conn, :index))
  end
end
