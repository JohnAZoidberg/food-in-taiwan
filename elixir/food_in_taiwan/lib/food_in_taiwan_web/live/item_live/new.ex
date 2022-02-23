defmodule FoodInTaiwanWeb.ItemLive.New do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Items
  alias FoodInTaiwan.Items.Item
  alias FoodInTaiwan.Tags

  def mount(_params, _session, socket) do
    # Transform to strings and IDs for the HTML forms
    tags = Tags.list_tags(1, 100) |> Map.new(fn tag -> {tag.name, tag.id} end)

    changeset = Items.change_item(%Item{}, [])
    {:ok, assign(socket, changeset: changeset, tags: tags)}
  end

  def handle_params(_params, _url, socket) do
    # Transform to strings and IDs for the HTML forms
    tags = Tags.list_tags(1, 100) |> Map.new(fn tag -> {tag.name, tag.id} end)

    changeset = Items.change_item(%Item{}, [])
    {:noreply, assign(socket, changeset: changeset, tags: tags)}
  end

  def handle_event("validate", %{"item" => item_params}, socket) do
    # Turn IDs back to full objects
    tag_ids = item_params["tags"] |> Enum.map(&String.to_integer/1)
    tags = Tags.list_tags(1, 100) |> Enum.filter(fn tag -> Enum.member?(tag_ids, tag.id) end)

    changeset =
      %Item{}
      |> FoodInTaiwan.Items.change_item(item_params, tags)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"item" => item_params}, socket) do
    # Turn IDs back to full objects
    tag_ids = item_params["tags"] |> Enum.map(&String.to_integer/1)
    tags = Tags.list_tags(1, 100) |> Enum.filter(fn tag -> Enum.member?(tag_ids, tag.id) end)

    case Items.create_item(item_params, tags) do
      {:ok, item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Item created")
         |> push_redirect(to: Routes.item_show_path(socket, :show, item))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
