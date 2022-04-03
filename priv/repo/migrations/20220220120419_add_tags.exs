defmodule FoodInTaiwan.Repo.Migrations.AddTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :explanation, :string
      timestamps()
    end

    create table(:item_tags, primary_key: false) do
      add :tag_id, references(:tags, on_delete: :delete_all), primary_key: true
      add :item_id, references(:items, on_delete: :delete_all), primary_key: true
      # timestamps() # Won't work...
    end

    create(index(:item_tags, [:item_id]))
    create(index(:item_tags, [:tag_id]))
    create(unique_index(:item_tags, [:item_id, :tag_id], name: :item_id_tag_id_unique_index))
  end
end
