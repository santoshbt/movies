defmodule MoviesWeb.MovieView do
  use MoviesWeb, :view
  alias MoviesWeb.MovieService

  def adult_content(adult) do
    if adult, do: "Yes", else: "No"
  end

  def user_movie(%{movie_id: movie_id}) do
    MovieService.get(movie_id)["title"]
  end
end
