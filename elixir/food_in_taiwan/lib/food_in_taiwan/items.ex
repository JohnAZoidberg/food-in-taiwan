defmodule FoodInTaiwan.Items do
  @moduledoc """
  The Items context.
  """

  import Ecto.Query, warn: false
  alias FoodInTaiwan.Repo

  alias FoodInTaiwan.Items.Item

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(FoodInTaiwan.PubSub, @topic)
  end

  def subscribe(item_id) do
    Phoenix.PubSub.subscribe(FoodInTaiwan.PubSub, @topic <> "#{item_id}")
  end

  @doc """
  Returns the list of items.
  ## Examples
      iex> list_items()
      [%Item{}, ...]
  """
  def list_items(current_page, per_page) do
    Repo.all(
      from u in Item,
        order_by: [asc: u.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end

  @doc """
  Gets a single item.
  Raises `Ecto.NoResultsError` if the Item does not exist.
  ## Examples
      iex> get_item!(123)
      %Item{}
      iex> get_item!(456)
      ** (Ecto.NoResultsError)
  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates an item.
  ## Examples
      iex> create_item(%{field: value})
      {:ok, %Item{}}
      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:item, :created])
  end

  @doc """
  Updates a item.
  ## Examples
      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}
      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:item, :updated])
  end

  @doc """
  Deletes a Item.
  ## Examples
      iex> delete_item(item)
      {:ok, %Item{}}
      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}
  """
  def delete_item(%Item{} = item) do
    item
    |> Repo.delete()
    |> notify_subscribers([:item, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.
  ## Examples
      iex> change_item(item)
      %Ecto.Changeset{source: %Item{}}
  """
  def change_item(item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(FoodInTaiwan.PubSub, @topic, {__MODULE__, event, result})

    Phoenix.PubSub.broadcast(
      FoodInTaiwan.PubSub,
      @topic <> "#{result.id}",
      {__MODULE__, event, result}
    )

    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
