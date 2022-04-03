defmodule FoodInTaiwan.Repo.Migrations.AddUrls do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add(:wikipedia_url, :string)
      add(:picture_url, :string)
    end
  end
end
