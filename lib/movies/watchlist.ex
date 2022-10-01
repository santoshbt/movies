defmodule Movies.Watchlist do
  @moduledoc """
  The Watchlist context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias Movies.Repo

  alias Movies.Watchlist.Movie
  alias MoviesWeb.MovieService

  @doc """
  Returns the list of movies.

  ## Examples

      iex> list_movies()
      [%Movie{}, ...]

  """
  def list_movies do
    Repo.all(Movie)
  end

  def get_movie!(id), do: MovieService.get(id)

  # @doc """
  # Returns an `%Ecto.Changeset{}` for tracking movie changes.

  # ## Examples

  #     iex> change_movie(movie)
  #     %Ecto.Changeset{data: %Movie{}}

  # """
  # def change_movie(%Movie{} = movie, attrs \\ %{}) do
  #   Movie.changeset(movie, attrs)
  # end

  def create_movie(attrs \\ %{}) do
    %Movie{}
    |> Movie.changeset(attrs)
    |> Repo.insert()
  end

  def search(movie_name) when is_binary(movie_name) do
    MovieService.search(movie_name)
  end

  def search(_), do: "Not a valid movie name"

  def watch_movie(current_user, movie_id) do
    user_movie = find_or_insert(movie_id)
    user_loaded = Repo.preload(current_user, [:movies])
    user_loaded
        |> Changeset.change()
        |> Changeset.put_assoc(:movies, [user_movie | user_loaded.movies])
        |> Repo.update!()
  end

  defp find_or_insert(movie_id) do
    {movie_id, ""} = Integer.parse(movie_id)
    required_movie = get!(movie_id)

    if required_movie do
      required_movie
    else
      {:ok, movie} = create_movie(%{movie_id: movie_id})
      movie
    end
  end

  defp get!(movie_id) do
    Movie |> Repo.get_by(movie_id: movie_id)
  end
end
