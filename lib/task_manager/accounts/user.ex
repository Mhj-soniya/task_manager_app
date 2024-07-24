defmodule TaskManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    # field :password, :string, virtual: true


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs\\%{}) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_required([:name, :email, :password_hash])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password_hash, min: 7)
    # |> put_password_hash()
  end

  # defp put_password_hash(changeset) do
  #   case get_change(changeset, :password) do
  #     nil -> changeset
  #     password -> put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  #   end
  # end

end
