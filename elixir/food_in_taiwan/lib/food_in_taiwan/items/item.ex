defmodule FoodInTaiwan.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :description])

    # |> validate_required([:username, :email, :phone_number])
  end
end
