defmodule MoviesWeb.CurrentUserController do
  defmacro __using__(_) do
    quote do
      def action(conn, _) do
        args = [conn, conn.params, conn.assigns.current_user]
        apply(__MODULE__, action_name(conn), args)
      end
    end
  end
end
