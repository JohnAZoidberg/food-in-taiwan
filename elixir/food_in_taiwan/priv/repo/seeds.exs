# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodInTaiwan.Repo.insert!(%FoodInTaiwan.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias FoodInTaiwan.Items.Tag
alias FoodInTaiwan.Tags

tags =
  Tags.seasons()
  |> Enum.concat(FoodInTaiwan.Tags.temperatures())
  |> Enum.map(fn name -> Tag.changeset(%Tag{}, %{name: name}) end)
  |> Enum.each(&FoodInTaiwan.Repo.insert!/1)
