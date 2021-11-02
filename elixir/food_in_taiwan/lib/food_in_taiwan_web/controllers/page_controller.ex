defmodule FoodInTaiwanWeb.PageController do
  use FoodInTaiwanWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
