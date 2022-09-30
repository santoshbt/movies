defmodule Movies.Watchlist.UserMovie do
  @moduledoc """
    UserMovie module
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Movies.Users.User
  alias Movies.Watchlist.Movie

  @primary_key false
  schema "user_movie" do
    belongs_to(:user, User, primary_key: true)
    belongs_to(:movies, Movie, primary_key: true)

    timestamps()
  end

  @required_fields ~w(user_id project_id)a
  def changeset(user_movie, params \\ %{}) do
    user_movie
      |> cast(params, @required_fields)
      |> validate_required(@required_fields)
      |> foreign_key_constraint(:user_id)
      |> foreign_key_constraint(:movie_id)
      |> unique_constraint([:user, :movie],
          name: :user_id_movie_id_unique_index,
          message: "Already exists"
      )
  end
end
