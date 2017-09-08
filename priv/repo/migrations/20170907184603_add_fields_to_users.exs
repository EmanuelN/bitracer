defmodule Bitracer.Repo.Migrations.AddFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :coins, :integer
      add :avatar, :string
    end

  end
end
