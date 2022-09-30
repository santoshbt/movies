defmodule Movies.WatchlistFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Movies.Watchlist` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        movie_id: 42
      })
      |> Movies.Watchlist.create_movie()

    movie
  end
end
