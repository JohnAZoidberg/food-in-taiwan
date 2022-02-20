defmodule FoodInTaiwan.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :description, :string
    field :wikipedia_url, :string
    field :picture_url, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description, :wikipedia_url, :picture_url])

    # |> validate_required([:username, :email, :phone_number])
  end
end
