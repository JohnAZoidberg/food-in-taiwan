defmodule FoodInTaiwan.Repo.Migrations.AddMandarinMeaning do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add(:mandarin, :string)
      add(:meaning, :string)
    end
  end
end
