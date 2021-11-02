defmodule FoodInTaiwanWeb.ItemLive.IndexManualScroll do
  use FoodInTaiwanWeb, :live_view

  def render(assigns) do
    ~H"""
    <table>
      <tbody phx-update="append" id="items">
        <%= for item <- @items do %>
          <tr class="item-row" id={"item-#{item.id}"}>
            <td><%= item.name %></td>
            <td><%= item.description %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    <form phx-submit="load-more">
      <button phx-disable-with="loading...">more</button>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 10, val: 0)
     |> fetch(), temporary_assigns: [items: []]}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, items: FoodInTaiwan.Items.list_items(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
end
