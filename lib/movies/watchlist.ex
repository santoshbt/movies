defmodule Movies.Watchlist do
  @moduledoc """
  The Watchlist context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Changeset
  alias Movies.Repo

  alias Movies.Watchlist.{Movie, UserMovie}
  alias MoviesWeb.MovieService

  def list_movies(user) do
    user = user |> Repo.preload(:movies)
    user.movies
  end

  @spec get_movie!(any) :: false | nil | true | binary | list | number | map
  def get_movie!(id), do: MovieService.get(id)

  def create_movie(attrs \\ %{}) do
    %Movie{}
    |> Movie.changeset(attrs)
    |> Repo.insert()
  end

  def search(movie_name) when is_binary(movie_name) do
    MovieService.search(movie_name)
  end

  def search(_), do: "Not a valid movie name"

  def watch_movie(user, movie_id) do
    user_movie = find_or_insert(movie_id)
    user_loaded = Repo.preload(user, [:movies])

    user_loaded
    |> Changeset.change()
    |> Changeset.put_assoc(:movies, [user_movie | user_loaded.movies])
    |> Repo.update!()
  end

  def remove(user, movie_id) do
    Repo.delete_all(user_movie_query(user.id, movie_id))
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

  defp user_movie_query(user_id, movie_id) do
    from(um in UserMovie,
      where: um.user_id == ^user_id,
      where: um.movie_id == ^movie_id
    )
  end
end
