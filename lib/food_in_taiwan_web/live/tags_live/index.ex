defmodule FoodInTaiwanWeb.TagLive.Index do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Tags
  alias FoodInTaiwanWeb.Router.Helpers, as: Routes

  def mount(_params, _session, socket) do
    if connected?(socket), do: Tags.subscribe()
    {:ok, assign(socket, page: 1, per_page: 10)}
  end

  def handle_params(params, _url, socket) do
    {page, ""} = Integer.parse(params["page"] || "1")
    {:noreply, socket |> assign(page: page) |> fetch()}
  end

  defp fetch(socket) do
    %{page: page, per_page: per_page} = socket.assigns
    tags = Tags.list_tags(page, per_page)
    assign(socket, tags: tags, page_title: "Tags - Page #{page}")
  end

  def handle_info({Tags, [:tags | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page - 1)}
  end

  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page + 1)}
  end

  def handle_event("keydown", _, socket), do: {:noreply, socket}

  def handle_event("delete_tag", %{"id" => id}, socket) do
    tag = Tags.get_tag!(id)
    {:ok, _tag} = Tags.delete_tag(tag)

    {:noreply, socket}
  end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: Routes.tag_index_path(socket, :index, page: page))
  end

  defp go_page(socket, _page), do: socket
end
