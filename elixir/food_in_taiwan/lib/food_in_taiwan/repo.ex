defmodule FoodInTaiwan.Repo do
  use Ecto.Repo,
    otp_app: :food_in_taiwan,
    #adapter: Ecto.Adapters.Postgres
    adapter: Ecto.Adapters.SQLite3
end
