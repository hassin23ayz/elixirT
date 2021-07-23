# the config.exs file is a script that's evaluated by the mix tool
# when compiling the project and starting the application
# in these scripts you cannot invoke functions from your own module
# you can't make runtime decisions in config scripts

use Mix.Config

config :todo_http, :database, pool_size: 3, folder: "./persist"
config :todo_http, port: 5454
config :todo_http, todo_item_expiry: :timer.minutes(1)

# A mix environment determines the compilation target, such as development , test or production
# config.exs provides common settings for all mix configurations , whereas environment specific file such as
# test.exs are used to vary some settings
import_config "#{Mix.env()}.exs"
