defmodule FoodInTaiwanWeb.ItemLive.Row do
  use FoodInTaiwanWeb, :live_component

  defmodule Email do
    use FoodInTaiwanWeb, :live_component

    def mount(socket) do
      {:ok, assign(socket, count: 0), temporary_assigns: [email: nil]}
    end

    def render(assigns) do
      ~H"""
      <span id={@id} phx-click="click" phx-target={@myself}>
        Email: <%= @email %> <%= @count %>
      </span>
      """
    end

    def handle_event("click", _, socket) do
      {:noreply, update(socket, :count, &(&1 + 1))}
    end
  end

  def mount(socket) do
    {:ok, assign(socket, count: 0), temporary_assigns: [item: nil]}
  end

  def render(assigns) do
    ~H"""
    <tr class="item-row" id={@id} phx-click="click" phx-target={@myself}>
      <td><%= @item.name %> <%= @count %></td>
      <td><%= @item.description %> <%= @item.description %></td>
    </tr>
    """

    # <td>
    #  <%= live_component @socket, Email, id: "description-#{@id}", email: @item.email %>
    # </td>
  end

  def handle_event("click", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end

defmodule FoodInTaiwanWeb.ItemLive.IndexAutoScroll do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwanWeb.ItemLive.Row

  def render(assigns) do
    ~H"""
    <table>
      <tbody id="items"
             phx-update="append"
             phx-hook="InfiniteScroll"
             data-page={@page}>
        <%= for item <- @items do %>
          <%= live_component @socket, Row, id: "item-#{item.id}", item: item %>
        <% end %>
      </tbody>
    </table>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 10)
     |> fetch(), temporary_assigns: [items: []]}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, items: FoodInTaiwan.Items.list_items(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
end
