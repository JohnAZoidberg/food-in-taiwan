defmodule FoodInTaiwanWeb.ItemLive.Edit do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Items
  alias FoodInTaiwan.Tags

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    item = Items.get_item!(id)

    # Transform to strings and IDs for the HTML forms
    tags = Tags.list_tags(1, 100) |> Map.new(fn tag -> {tag.name, tag.id} end)
    selected = item.tags |> Enum.map(fn tag -> tag.id end)

    {:noreply,
     assign(socket, %{
       item: item,
       changeset: Items.change_item(item, []),
       tags: tags,
       selected: selected
     })}
  end

  def tags_as_str_list(nil), do: []
  def tags_as_str_list(list) when is_list(list) do
       list |> Enum.map(&String.to_integer/1)
  end

  def handle_event("validate", %{"item" => params}, socket) do
    # Turn IDs back to full objects
    tag_ids = tags_as_str_list(params["tags"])
    tags = Tags.list_tags(1, 100) |> Enum.filter(fn tag -> Enum.member?(tag_ids, tag.id) end)

    changeset =
      socket.assigns.item
      |> FoodInTaiwan.Items.change_item(params, tags)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"item" => params}, socket) do
    # Turn IDs back to full objects
    tag_ids = tags_as_str_list(params["tags"])
    tags = Tags.list_tags(1, 100) |> Enum.filter(fn tag -> Enum.member?(tag_ids, tag.id) end)

    case Items.update_item(socket.assigns.item, params, tags) do
      {:ok, item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Item updated successfully.")
         |> push_redirect(to: Routes.item_show_path(socket, :show, item))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
