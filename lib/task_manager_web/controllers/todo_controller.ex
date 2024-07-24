defmodule TaskManagerWeb.TodoController do
  use TaskManagerWeb, :controller

  alias TaskManager.Todo
  alias TaskManager.Todo.Task

  # Use the Auth plug to ensure the user is authenticated
  plug TaskManagerWeb.Auth when action in [:index, :create, :update, :delete]
  plug :authenticate_user when action in [:index, :new, :create, :edit, :update, :delete]

  defp authenticate_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "You need to log in to access this page")
      |> redirect(to: "/login")
      |> halt()
    end
  end

  def index(conn, %{"filter" => filter}) do
    user_id = conn.assigns[:current_user].id

    task = case filter do
      "completed" -> Todo.list_completed_todos_for_user(user_id)
      "active" -> Todo.list_active_todos_for_user(user_id)
      _ -> Todo.list_todos_for_user(user_id)
    end

    changeset = Task.changeset(%Task{})
    render(conn, :new, changeset: changeset, task: task)
  end

  def new(conn, _params) do
    changeset = Task.changeset(%Task{})
    task = Todo.list_todos_for_user(conn.assigns[:current_user].id)
    render(conn, :new, changeset: changeset, task: task)
  end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"task" => task_params}) do
    user_id = conn.assigns[:current_user].id
    task_params = Map.put(task_params, "user_id", user_id)

    case Todo.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task inserted successfully")
        |> redirect(to: "/todo/new")
      {:error, %Ecto.Changeset{} = changeset} ->
        task = Todo.list_todos_for_user(user_id)
        render(conn, :new, changeset: changeset, task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns[:current_user].id
    task = Todo.get_task!(id)

    if task.user_id == user_id do
      {:ok, _task} = Todo.delete_task(task)

      conn
      |> put_flash(:info, "Task removed successfully")
      |> redirect(to: "/todo/new")
    else
      conn
      |> put_flash(:error, "You are not authorized to delete this task")
      |> redirect(to: "/todo/new")
    end
  end

  def update(conn, %{"id" => id}) do
    user_id = conn.assigns[:current_user].id
    task = Todo.get_task!(id)

    if task.user_id == user_id do
      case Todo.update_task(task, %{"completed" => true}) do
        {:ok, _task} ->
          conn
          |> put_flash(:info, "Task marked as completed")
          |> redirect(to: "/todo/new")
        {:error, %Ecto.Changeset{} = changeset} ->
          task = Todo.list_todos_for_user(user_id)
          render(conn, :new, changeset: changeset, task: task)
      end
    else
      conn
      |> put_flash(:error, "You are not authorized to update this task")
      |> redirect(to: "/todo/new")
    end
  end
end
