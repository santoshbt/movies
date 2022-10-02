defmodule Movies.Watchlist.Movie do
  use Ecto.Schema
  import Ecto.Changeset
  alias Movies.Users.User

  schema "movies" do
    field :movie_id, :integer

    many_to_many(
      :users,
      User,
      join_through: "user_movie",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:movie_id])
    |> validate_required([:movie_id])
  end
end
