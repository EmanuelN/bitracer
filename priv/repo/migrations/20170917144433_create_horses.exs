defmodule Bitracer.Repo.Migrations.CreateHorses do
  use Ecto.Migration

  def change do
    create table(:horses) do
      add :name, :string
      add :wins, :integer
      add :losses, :integer

      timestamps()
    end

  end
end
