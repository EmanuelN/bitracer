defmodule Bitracer.Records.Bet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bitracer.Records.Bet


  schema "bets" do
    field :amount, :integer
    belongs_to :user, Bitracer.Accounts.User
    belongs_to :horse, Bitracer.Records.Horse
    timestamps()
  end

  @doc false
  def changeset(%Bet{} = bet, attrs) do
    bet
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
