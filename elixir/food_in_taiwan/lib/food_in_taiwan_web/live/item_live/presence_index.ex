defmodule FoodInTaiwanWeb.ItemLive.PresenceIndex do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Items
  alias FoodInTaiwanWeb.Presence
  alias Phoenix.Socket.Broadcast

  def mount(%{"name" => name}, _session, socket) do
    if connected?(socket) do
      FoodInTaiwan.Items.subscribe()
      Phoenix.PubSub.subscribe(FoodInTaiwan.PubSub, "items")
      Presence.track(self(), "items", name, %{})
    end
    {:ok, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, %{
      items: Items.list_items(1, 10),
      online_items: FoodInTaiwanWeb.Presence.list("items"),
      page: 0
    })
  end

  def handle_info(%Broadcast{event: "presence_diff"}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Items, [:item | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("delete_item", id, socket) do
    item = Items.get_item!(id)
    {:ok, _item} = Items.delete_item(item)

    {:noreply, socket}
  end
end
