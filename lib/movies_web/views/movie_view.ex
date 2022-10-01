defmodule MoviesWeb.MovieView do
  use MoviesWeb, :view

  def adult_content(adult) do
    if adult, do: "Yes", else: "No"
  end
end
