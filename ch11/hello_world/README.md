# HelloWorld

An OTP application is a component that consists of multiple modules 
An OTP application can depend on other Applications 
An Application is an OTP specific construct 
Application resource file: a plain text file written in Erlang that describes the Application 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hello_world` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hello_world, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/hello_world](https://hexdocs.pm/hello_world).

## Usage

$mix new hello_world --sup
$iex -S mix
>Application.started_applications()

