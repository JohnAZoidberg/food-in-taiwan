defmodule FoodInTaiwanWeb.TagLive.New do
  use FoodInTaiwanWeb, :live_view

  alias FoodInTaiwan.Tags
  alias FoodInTaiwan.Items.Tag

  def mount(_params, _session, socket) do
    changeset = Tags.change_tag(%Tag{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("validate", %{"tag" => tag_params}, socket) do
    changeset =
      %Tag{}
      |> FoodInTaiwan.Tags.change_tag(tag_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"tag" => tag_params}, socket) do
    case Tags.create_tag(tag_params) do
      {:ok, _tag} ->
        {:noreply,
         socket
         |> put_flash(:info, "tag created")
         |> push_redirect(to: Routes.tag_index_path(socket, :index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
