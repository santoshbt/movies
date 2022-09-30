defmodule Movies.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :movie_id, :integer

      timestamps()
    end

    create index(:movies, [:movie_id])
  end
end
