# this file is an application resource file
# A plain text file written in erlang terms that describes the application
defmodule HelloWorld.MixProject do
  use Mix.Project

  def project do                                               # Describes the project
    [
      app: :hello_world,                                       # only an atom is allowed as an application name
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do                                         # this funtion Describes the application
    [
      extra_applications: [:logger],                         # the application can depend on other applications
      mod: {HelloWorld.Application, []}                      # tuple 1st elem: describes the Module that will be used to start the application
                                                             # tuple 2nd elem: when Application starts the Module.start() funtion gets invoked
                                                             #                 with the [] as argument
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do                                              # this function list 3rd party dependencies
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
