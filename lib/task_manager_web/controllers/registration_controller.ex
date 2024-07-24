defmodule TaskManagerWeb.RegistrationController do
  use TaskManagerWeb, :controller

  alias TaskManager.Accounts
  alias TaskManager.Accounts.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_param}) do
    case Accounts.create_user(user_param) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Account Created Successfully")
        |> redirect(to: "/login")
      {:error, %Ecto.Changeset{}=changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
