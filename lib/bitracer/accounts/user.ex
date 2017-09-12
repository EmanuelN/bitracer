defmodule Bitracer.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bitracer.Accounts.User
  import Comeonin.Bcrypt


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :username, :string
    field :coins, :integer, default: 1000
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    if Bitracer.Accounts.get_user!(user.id) do
      user
      |> cast(attrs, [:coins])
    else
      user
      |> cast(attrs, [:username, :email, :password, :password_confirmation])
      |> validate_required([:username, :email, :password, :password_confirmation])
      |> validate_length(:password, min: 6)
      |> validate_length(:password_confirmation, min: 6)
      |> unique_constraint(:email)
      |> unique_constraint(:username)
      |> validate_confirmation(:password)
    end
  end
end
