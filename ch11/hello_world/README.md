# HelloWorld

-An OTP application is a component that consists of multiple modules 
-An OTP application can depend on other Applications 

-create a new project 
$ mix new hello_world --sup 

-sup makes mix tool generate the application callback module and start the empty childless supervisor from it

-start the system 
$ iex -S mix 

-Calling iex -S mix automatically starts theapplication together with its dependencies
-It should be noted that you can’t start multiple instances of a single application. In this sense, an application is like a singleton in a   single BEAM instance

-But Application.stop/1 stops only the specified application, leaving dependencies (other applications) running. To stop the entire system in a controlled way, you can invoke System.stop/0

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

