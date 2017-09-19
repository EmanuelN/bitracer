defmodule Bitracer.Records.Bet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bitracer.Records.Bet


  schema "bets" do
    field :amount, :integer
    field :paid_out, :boolean
    belongs_to :user, Bitracer.Accounts.User
    belongs_to :horse, Bitracer.Records.Horse
    timestamps()
  end

  @doc false
  def changeset(%Bet{} = bet, attrs) do
    bet
    |> cast(attrs, [:amount, :paid_out])
    |> validate_required([:amount, :paid_out])
  end
end
