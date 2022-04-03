#  {
#    "uuid": "",
#    "name": {
#      "english": null,
#      "pinyin": "",
#      "mandarin": "",
#      "mandarin_translated": "",
#      "japanese": null
#    },
#    "tags": [],
#    "type": "dish",
#    "description": "",
#    "ingredients": [],
#    "season": "",
#    "temperature": "",
#    "commonly_eaten_with": [],
#    "picture_url": "",
#    "wikipedia_url": ""
#  }
defmodule FoodInTaiwan.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias FoodInTaiwan.Items.Tag

  schema "items" do
    field :name, :string
    field :mandarin, :string
    field :meaning, :string

    field :description, :string
    field :wikipedia_url, :string
    field :picture_url, :string

    many_to_many :tags, Tag, join_through: "item_tags", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    changeset_update_tags(item, attrs, [])
  end

  def changeset_update_tags(item, attrs, tags) do
    IO.inspect(attrs, label: "changeset_update_tags: Attrs")
    IO.inspect(tags, label: "changeset_update_tags: Tags")

    item
    |> cast(attrs, [:name, :mandarin, :meaning, :description, :wikipedia_url, :picture_url])
    |> validate_required([:name])
    |> put_assoc(:tags, tags)
  end
end
