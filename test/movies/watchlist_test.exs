defmodule Movies.WatchlistTest do
  use Movies.DataCase

  alias Movies.Watchlist

  describe "movies" do
    alias Movies.Watchlist.Movie

    import Movies.WatchlistFixtures

    @invalid_attrs %{movie_id: nil}

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert Watchlist.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert Watchlist.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      valid_attrs = %{movie_id: 42}

      assert {:ok, %Movie{} = movie} = Watchlist.create_movie(valid_attrs)
      assert movie.movie_id == 42
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Watchlist.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()
      update_attrs = %{movie_id: 43}

      assert {:ok, %Movie{} = movie} = Watchlist.update_movie(movie, update_attrs)
      assert movie.movie_id == 43
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = Watchlist.update_movie(movie, @invalid_attrs)
      assert movie == Watchlist.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = Watchlist.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Watchlist.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = Watchlist.change_movie(movie)
    end
  end
end
