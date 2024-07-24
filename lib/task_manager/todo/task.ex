defmodule TaskManager.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :text, :string
    field :completed, :boolean, default: false
    field :user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs \\ %{}) do
    task
    |> cast(attrs, [:text, :completed, :user_id])
    |> validate_required([:text, :user_id])
  end
end
