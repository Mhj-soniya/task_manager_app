defmodule TaskManagerWeb.Auth do
  @moduledoc """
  Creating Authentication Plug
  Creating a plug to handle user authentication.
  """
  import Plug.Conn

  alias TaskManager.Repo
  alias TaskManager.Accounts.User

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = if user_id, do: Repo.get(User, user_id)
    assign(conn, :current_user, user)
  end

  # defp authenticate_user(conn, _opts) do
  #   if conn.assigns[:current_user] do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "You need to log in to access this page")
  #     |> redirect(to: "/login")
  #     |> halt()
  #   end
  # end
end
