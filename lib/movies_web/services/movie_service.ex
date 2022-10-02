defmodule MoviesWeb.MovieService do
  @moduledoc """
    Service to call the external APIs for Movies DB
  """

  def search(name) do
    base_url = Application.get_env(:movies, :movies_db_search_base_url)
    api_key = Application.get_env(:movies, :api_key)
    encoded_param = encode_param(name)

    search_url = "#{base_url}?api_key=#{api_key}&#{encoded_param}"
    response = HTTPoison.get!(search_url)

    case Poison.decode(response.body) do
      {:ok, response_body} -> response_body
      _ -> nil
    end
  end

  def get(id) do
    base_url = Application.get_env(:movies, :movies_db_get_url)
    api_key = Application.get_env(:movies, :api_key)

    get_url = "#{base_url}/#{id}?api_key=#{api_key}"
    response = HTTPoison.get!(get_url)

    case Poison.decode(response.body) do
      {:ok, response_body} -> response_body
      _ -> nil
    end
  end

  defp encode_param(name) do
    query = %{"query" => name}
    URI.encode_query(query, :rfc3986)
  end
end
