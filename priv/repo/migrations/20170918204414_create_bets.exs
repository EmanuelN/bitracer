defmodule Bitracer.Repo.Migrations.CreateBets do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :amount, :integer

      timestamps()
    end

  end
end
