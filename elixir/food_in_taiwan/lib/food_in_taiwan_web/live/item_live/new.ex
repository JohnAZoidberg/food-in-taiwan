defmodule FoodInTaiwanWeb.ItemLive.New do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Items
  alias FoodInTaiwan.Items.Item

  def mount(_params, _session, socket) do
    changeset = Items.change_item(%Item{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("validate", %{"item" => item_params}, socket) do
    changeset =
      %Item{}
      |> FoodInTaiwan.Items.change_item(item_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"item" => item_params}, socket) do
    case Items.create_item(item_params) do
      {:ok, item} ->
        {:noreply,
         socket
         |> put_flash(:info, "item created")
         |> push_redirect(to: Routes.item_show_path(socket, :show, item))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
