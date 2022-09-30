defmodule MoviesWeb.MovieController do
  use MoviesWeb, :controller

  alias Movies.Watchlist
  alias Movies.Watchlist.Movie

  def index(conn, _params) do
    movies = Watchlist.list_movies()
    render(conn, "index.html", movies: movies)
  end

  def new(conn, _params) do
    changeset = Watchlist.change_movie(%Movie{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"movie" => movie_params}) do
    case Watchlist.create_movie(movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie created successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    movie = Watchlist.get_movie!(id)
    render(conn, "show.html", movie: movie)
  end

  def edit(conn, %{"id" => id}) do
    movie = Watchlist.get_movie!(id)
    changeset = Watchlist.change_movie(movie)
    render(conn, "edit.html", movie: movie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Watchlist.get_movie!(id)

    case Watchlist.update_movie(movie, movie_params) do
      {:ok, movie} ->
        conn
        |> put_flash(:info, "Movie updated successfully.")
        |> redirect(to: Routes.movie_path(conn, :show, movie))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", movie: movie, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Watchlist.get_movie!(id)
    {:ok, _movie} = Watchlist.delete_movie(movie)

    conn
    |> put_flash(:info, "Movie deleted successfully.")
    |> redirect(to: Routes.movie_path(conn, :index))
  end
end
