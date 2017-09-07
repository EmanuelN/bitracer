defmodule Bitracer.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bitracer.Accounts.User


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :encrypted_password])
    |> validate_required([:username, :email, :encrypted_password])
  end
end
