defmodule TodoDistributed.MixProject do
  use Mix.Project

  def project do
    [
      app: :todo_distributed,
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
      mod: {TodoDistributed.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poolboy, "~> 1.5"},
      {:cowboy, "~> 1.1"},
      {:plug, "~> 1.4"},
      {:plug_cowboy, "~> 1.0"}
    ]
  end
end
