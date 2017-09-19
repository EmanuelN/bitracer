defmodule Bitracer.Repo.Migrations.UpdateBetsTable do
  use Ecto.Migration

  def change do
    alter table(:bets) do
      add :horse_id, references("horses")
      add :user_id, references("users")
    end
  end
end
