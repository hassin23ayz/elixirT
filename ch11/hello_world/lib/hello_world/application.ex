defmodule HelloWorld.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application                # An Application is an OTP behaviour, powered by the Application Module
                                 # at minimum this callback module must contain atleast the start/2 callback function
  @impl true
  def start(_type, _args) do     # the application/0 function in the mix.exs file calls the function when application is started
    children = [
      # Starts a worker by calling: HelloWorld.Worker.start_link(arg)
      # {HelloWorld.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloWorld.Supervisor]
    Supervisor.start_link(children, opts)                              # the task of start/2 function is to start the top level process of your system
                                                                       # which should usually be a supervisor
                                                                       # this function returns {:ok, pid} or {:error, reason}
  end
end
