defmodule FoodInTaiwanWeb.ItemLive.Show do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Items
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~H"""
    <h2><%= @item.name %></h2>

    <!-- TODO: On mobile I'm gonna wanna do flex-wrap: wrap; -->
    <div style="display: flex">
      <p><%= @item.description %></p>

      <a style="width: 200px" href={"#{@item.picture_url}"} target="_blank">
        <img src={"#{@item.picture_url}"} />
      </a>
    </div>

    <table>
      <tr>
        <th>Information</th>
        <th></th>
      </tr>
      <tr>
        <td>Main Ingredients</td>
        <td><a href="#">Soft Tofu</a>, <a href="#">Beef</a>, <a href="#">Chili</a>, <a href="#">豆瓣醬</a></td>
      </tr>
      <tr>
        <td>Commonly eaten with</td>
        <td><a href="#">Rice</a></td>
      </tr>
      <tr>
        <td>Commonly eaten</td>
        <td>Hot</td>
      </tr>
      <tr>
        <td>Season</td>
        <td>Winter</td>
      </tr>
      <tr>
        <td><a href={"#{@item.wikipedia_url}"}>Wikipedia</a></td>
        <td></td>
      </tr>
    </table>
    <table>
      <tr>
        <th>Names</th>
        <th></th>
      </tr>
      <tr>
        <td>English</td>
        <td>Mapo Tofu</td>
      </tr>
      <tr>
        <td>Chinese</td>
        <td>麻婆豆腐</td>
      </tr>
      <tr>
        <td>PinYin</td>
        <td>mápó dòufu</td>
      </tr>
      <tr>
        <td>ZhuYin</td>
        <td>ㄇㄚˊ ㄆㄛˊ ㄉㄡˋ ㄈㄨ</td>
      </tr>
      <tr>
        <td>Literal Meaning</td>
        <td>pockmarked old woman, beancurd</td>
      </tr>
    </table>
    <span><%= live_redirect "Edit", to: Routes.item_edit_path(@socket, :edit, @item) %></span>
    <span><%= live_redirect "Back", to: Routes.item_index_path(@socket, :index) %></span>
    """
  end

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
