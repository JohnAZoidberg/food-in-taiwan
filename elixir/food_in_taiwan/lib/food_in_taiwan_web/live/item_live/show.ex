defmodule FoodInTaiwanWeb.ItemLive.Show do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Items
  alias Phoenix.LiveView.Socket

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: FoodInTaiwan.Items.subscribe(id)
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    assign(socket, item: Items.get_item!(id))
  end

  def handle_info({Items, [:item, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Items, [:item, :deleted], _}, socket) do
    {:noreply,
     socket
     |> put_flash(:error, "This item has been deleted from the system")
     |> push_redirect(to: Routes.item_index_path(socket, :index))}
  end
end
