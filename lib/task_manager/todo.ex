defmodule TaskManager.Todo do
  @moduledoc """
  The Todo context.
  """

  import Ecto.Query, warn: false
  alias TaskManager.Repo

  alias TaskManager.Todo.Task

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Task{}, ...]

  """
  def list_todos do
    Repo.all(Task)
  end

  def list_todos_for_user(user_id) do
    Repo.all(from t in Task, where: t.user_id == ^user_id)
  end

  def list_completed_todos_for_user(user_id) do
    Repo.all(from t in Task, where: t.completed == true and t.user_id == ^user_id)
  end

  def list_active_todos_for_user(user_id) do
    Repo.all(from t in Task, where: t.completed == false and t.user_id == ^user_id)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
