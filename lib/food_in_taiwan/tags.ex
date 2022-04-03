defmodule FoodInTaiwan.Tags do
  @moduledoc """
  The Tags context.
  """

  import Ecto.Query, warn: false
  alias FoodInTaiwan.Repo

  alias FoodInTaiwan.Items.Tag

  @topic inspect(__MODULE__)

  def temperatures, do: ["Hot", "Cold"]
  def seasons, do: ["Winter", "Summer", "CNY", "Spring", "Autumn"]

  def subscribe do
    Phoenix.PubSub.subscribe(FoodInTaiwan.PubSub, @topic)
  end

  def subscribe(tag_id) do
    Phoenix.PubSub.subscribe(FoodInTaiwan.PubSub, @topic <> "#{tag_id}")
  end

  @doc """
  Returns the list of tags.
  ## Examples
      iex> list_tags()
      [%Tag{}, ...]
  """
  def list_tags(current_page, per_page) do
    Repo.all(
      from u in Tag,
        order_by: [asc: u.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end

  # TODO: Unused
  def get_tag_list(ids) do
    Repo.all(
      from u in Tag,
        order_by: [asc: u.id],
        where: u.id in ^ids
    )
  end

  @doc """
  Gets a single tag.
  Raises `Ecto.NoResultsError` if the Tag does not exist.
  ## Examples
      iex> get_tag!(123)
      %Tag{}
      iex> get_tag!(456)
      ** (Ecto.NoResultsError)
  """
  def get_tag!(id) do
    Repo.get!(Tag, id)
  end

  @doc """
  Creates an tag.
  ## Examples
      iex> create_tag(%{field: value})
      {:ok, %Tag{}}
      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:tag, :created])
  end

  @doc """
  Deletes a Tag.
  ## Examples
      iex> delete_tag(tag)
      {:ok, %Tag{}}
      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}
  """
  def delete_tag(%Tag{} = tag) do
    tag
    |> Repo.delete()
    |> notify_subscribers([:tag, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.
  ## Examples
      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}
  """
  def change_tag(tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
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
