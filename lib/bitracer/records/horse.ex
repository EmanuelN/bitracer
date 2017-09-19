defmodule Bitracer.Records.Horse do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bitracer.Records.Horse


  schema "horses" do
    field :losses, :integer
    field :name, :string
    field :wins, :integer
    has_many :bets, Bitracer.Records.Bet
    timestamps()
  end

  @doc false
  def changeset(%Horse{} = horse, attrs) do
    horse
    |> cast(attrs, [:name, :wins, :losses])
    |> validate_required([:name, :wins, :losses])
  end
end
