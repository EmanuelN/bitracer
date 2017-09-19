defmodule Bitracer.Repo.Migrations.AddPaidOutToBets do
  use Ecto.Migration

  def change do
    alter table(:bets) do
      add :paid_out, :boolean
    end
  end
end
