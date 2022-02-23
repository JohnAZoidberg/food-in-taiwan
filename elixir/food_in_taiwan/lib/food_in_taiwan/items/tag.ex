defmodule FoodInTaiwan.Items.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  # alias FoodInTaiwan.Items.Item

  schema "tags" do
    field :name, :string

    # many_to_many :items, Item, join_through: "item_tags", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
