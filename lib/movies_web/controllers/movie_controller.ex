defmodule MoviesWeb.MovieController do
  use MoviesWeb, :controller
  import MoviesWeb.Controllers.Helpers.CurrentUserHelper

  alias Movies.Watchlist
  alias Movies.Users.User

  def index(conn, _params) do
    if current_user(conn) do
      movies = Watchlist.list_movies(current_user(conn))
      IO.inspect(movies)
      render(conn, "index.html", movies: movies)
    else
      redirect_to_login(conn)
    end
  end

  def show(conn, %{"id" => id}) do
    if current_user(conn) do
      movie = Watchlist.get_movie!(id)
      render(conn, "show.html", movie: movie)
    else
      redirect_to_login(conn)
    end
  end

  def watch_later(conn, %{"id" => id}) do
    if current_user(conn) do
      case Watchlist.watch_movie(current_user(conn), id) do
        %User{} -> redirect_info(conn, :info, "Movie added to watchlist")
        {:error, _} -> redirect_info(conn, :error, "Something went wrong, please try again")
      end
    else
      redirect_to_login(conn)
    end
  end

  def remove_watchlist(conn, %{"id" => id}) do
    if current_user(conn) do
      case Watchlist.remove(current_user(conn), id) do
        {1, nil} ->
          redirect_info(conn, :info, "Movie removed from watchlist")

        {0, nil} ->
          redirect_info(conn, :error, "Moview not found in watchlist")
      end
    else
      redirect_to_login(conn)
    end
  end

  defp redirect_info(conn, type, message) do
    conn
    |> put_flash(type, message)
    |> redirect(to: Routes.movie_path(conn, :index))
  end

  defp redirect_to_login(conn) do
    message = "Please login"

    conn
    |> put_flash(:error, message)
    |> redirect(to: Routes.pow_session_path(conn, :new))
    |> halt()
  end
end
