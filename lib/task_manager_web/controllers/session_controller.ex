defmodule TaskManagerWeb.SessionController do
  @moduledoc """
  Controller for handling user sessions
  """
  use TaskManagerWeb, :controller

  alias TaskManager.Repo
  # alias TaskManager.Accounts
  alias TaskManager.Accounts.User

  def new(conn, _params) do
    # IO.inspect("workin' =======================================")
    render(conn, :new)
  end

  def create(conn, %{"_csrf_token" => _token, "email" => email, "password" => password}) do
    # IO.inspect("working =======================================")
    case Repo.get_by(User, email: email) do
      nil ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> render(:new)
      user ->
        if password == user.password_hash do
          conn
          |> put_session(:user_id, user.id)
          |> put_flash(:info, "Logged in successfully")
          |> redirect(to: "/todo/new")
        else
          conn
          |> put_flash(:error, "Invalid email or password")
          |> render(:new, email: email, password: "")
        end
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)  # Remove user ID from the session
    |> put_flash(:info, "You have been logged out.")
    |> redirect(to: "/login")
  end
end
