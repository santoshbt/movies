defmodule Movies.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias Movies.Watchlist.Movie

  schema "users" do
    pow_user_fields()
    many_to_many(
      :movies,
      Movie,
      join_through: "user_movie",
      on_replace: :delete
    )

    timestamps()
  end
end
