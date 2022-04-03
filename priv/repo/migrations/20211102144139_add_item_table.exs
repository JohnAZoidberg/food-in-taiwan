defmodule FoodInTaiwan.Repo.Migrations.AddItemTable do
  use Ecto.Migration

  def change do
    create table(:items) do
      add(:name, :string)
      add(:description, :string)

      timestamps()
    end
  end
end
