defmodule Movies.Repo.Migrations.AddTableUserMovie do
  use Ecto.Migration

  def change do
    create table(:user_movie, primary_key: false) do
      add(:movie_id, references(:movies, on_delete: :delete_all), primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
    end

    create index(:user_movie, [:movie_id])
    create index(:user_movie, [:user_id])
  end
end
