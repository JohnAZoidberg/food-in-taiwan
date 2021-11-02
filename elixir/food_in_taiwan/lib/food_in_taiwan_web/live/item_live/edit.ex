defmodule FoodInTaiwanWeb.ItemLive.Edit do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Items

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    item = Items.get_item!(id)
    {:noreply,
     assign(socket, %{
       item: item,
       changeset: Items.change_item(item)
     })}
  end

  def handle_event("validate", %{"item" => params}, socket) do
    changeset =
      socket.assigns.item
      |> FoodInTaiwan.Items.change_item(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"item" => item_params}, socket) do
    case Items.update_item(socket.assigns.item, item_params) do
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
