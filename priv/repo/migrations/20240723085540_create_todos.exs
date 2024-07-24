defmodule TaskManager.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :text, :string
      add :completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all)
      #Adds a user_id column that references the users table
      # If a user is deleted, all associated todos will also be deleted (on_delete: :delete_all).

      timestamps(type: :utc_datetime)
    end
    # Creates an index on the user_id column of the todos table to improve query
    # performance when filtering by user_id.
    create index(:todos, [:user_id])
  end
end
