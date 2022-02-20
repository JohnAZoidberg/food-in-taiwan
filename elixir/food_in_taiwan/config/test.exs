import Config

# Configure your database
config :food_in_taiwan, FoodInTaiwan.Repo,
  database: "food_items.db",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_in_taiwan, FoodInTaiwanWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "UIT5D1oIyyk8LCTHqiuGmhUacGKyw0J4429g2MwCSNGgSjH7X4uaAL1RGuyvLAAU",
  server: false

# In test we don't send emails.
config :food_in_taiwan, FoodInTaiwan.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
