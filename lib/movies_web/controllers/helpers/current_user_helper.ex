defmodule MoviesWeb.Controllers.Helpers.CurrentUserHelper do
  def current_user(conn), do: conn && Pow.Plug.current_user(conn)
end
