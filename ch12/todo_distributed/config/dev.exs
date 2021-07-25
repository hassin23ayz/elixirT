use Mix.Config

config :todo_distributed, todo_item_expiry: :timer.seconds(10)
