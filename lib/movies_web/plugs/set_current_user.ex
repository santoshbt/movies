defmodule MoviesWeb.Plugs.SetCurrentUser do
  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do
    cond do
      current_user = conn && Pow.Plug.current_user(conn) ->
        conn
        |> assign(:current_user, current_user)
        |> assign(:user_signed_in?, true)

      true ->
        conn
        |> assign(:current_user, nil)
        |> assign(:user_signed_in?, false)
    end
  end
end
