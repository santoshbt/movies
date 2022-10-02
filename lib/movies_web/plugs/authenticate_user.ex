defmodule MoviesWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias MoviesWeb.Router.Helpers, as: Routes

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You need to sign in or sign up before continuing.")
      |> redirect(to: Routes.pow_session_path(conn, :new))
      |> halt()
    end
  end
end
