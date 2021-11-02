defmodule FoodInTaiwanWeb.ItemLive.Index do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Items
  alias FoodInTaiwanWeb.Router.Helpers, as: Routes

  def mount(_params, _session, socket) do
    if connected?(socket), do: Items.subscribe()
    {:ok, assign(socket, page: 1, per_page: 5)}
  end

  def handle_params(params, _url, socket) do
    {page, ""} = Integer.parse(params["page"] || "1")
    {:noreply, socket |> assign(page: page) |> fetch()}
  end

  defp fetch(socket) do
    %{page: page, per_page: per_page} = socket.assigns
    items = Items.list_items(page, per_page)
    assign(socket, items: items, page_title: "Listing items – Page #{page}")
  end

  def handle_info({Items, [:item | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page - 1)}
  end
  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page + 1)}
  end
  def handle_event("keydown", _, socket), do: {:noreply, socket}

  def handle_event("delete_item", %{"id" => id}, socket) do
    item = Items.get_item!(id)
    {:ok, _item} = Items.delete_item(item)

    {:noreply, socket}
  end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: Routes.item_index_path(socket, :index, page: page))
  end
  defp go_page(socket, _page), do: socket
end
