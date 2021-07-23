defmodule Todo.Web do
  use Plug.Router                    # adds some function to the module later used internally by Plug

  plug :match                        # Elixir Macro Invocations, Allow you to match different HTTP requests
  plug :dispatch

  def child_spec(_arg) do
    Plug.Adapters.Cowboy.child_spec( # returns child spec of processes responsible for the HTTP server part
      scheme: :http,
      options: [port: 5454],
      plug: __MODULE__               # the module which has the callback function to handle request
    )                                # it is possible to run multiple HTTP servers in the system
  end                                # for example adding another HTTP server for administration purposes

  # curl -d '' 'http://localhost:5454/add_entry?list=bob&date=2018-12-19&title=Dentist'

  # post macro to define request handling code [ like test macro in tdd]
  # because of this macro under the hood a do_match function runs for each request
  # conn variable is generated & passed by the post macro
  # conn var holds the TCP socket + information about the state of the request you are processing
  post "/add_entry" do
    conn = Plug.Conn.fetch_query_params(conn)                   # get a new version of the conn structure
    #IO.inspect(conn.params)
    list_name = Map.fetch!(conn.params, "list")                 # parse list
    title = Map.fetch!(conn.params, "title")                    # parse title
    date = Date.from_iso8601!(Map.fetch!(conn.params, "date"))  # parse date

    list_name                                                   # create a list
    |> Todo.Cache.server_process()
    |> Todo.Server.add_entry(%{title: title, date: date})       # add an entry to the list

    conn                                                        # respond to the request connection
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "OK")
  end

  # curl 'http://localhost:5454/entries?list=bob&date=2018-12-19'
  get "/entries" do
    conn = Plug.Conn.fetch_query_params(conn)
    #IO.inspect(conn.params)
    list_name = Map.fetch!(conn.params, "list")
    date = Date.from_iso8601!(Map.fetch!(conn.params, "date"))

    entries =
      list_name
      |> Todo.Cache.server_process()
      |> Todo.Server.entries(date)

    formatted_entries =
      entries
      |> Enum.map(&"#{&1.date} #{&1.title}")
      |> Enum.join("\n")

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, formatted_entries)
  end

  match _ do
    Plug.Conn.send_resp(conn, 404, "not found")
  end
end
