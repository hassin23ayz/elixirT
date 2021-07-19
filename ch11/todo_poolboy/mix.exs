defmodule TodoPoolboy.MixProject do
  use Mix.Project

  def project do
    [
      app: :todo_poolboy,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {TodoPoolboy.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poolboy, "~> 1.5"}  # An external dependency is specified as a tuple
                            # The second element in the tuple is the version requirement.
    ]
  end
end
