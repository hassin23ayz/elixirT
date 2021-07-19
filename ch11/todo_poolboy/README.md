# TodoPoolboy

-start a prod version you can invoke MIX_ENV=prod iex -S mix

-Depending on third-party libraries is an important feature.

-you will probably want to use various libraries such as 
 * Web frameworks 
 * Json Parser
 * database Drivers 

-The dependency to an external library must be specified in the mix.exs file

-An external dependency is specified as a tuple

-Dependencies are fetched from Elixir’s external package manager,
which is called Hex (http://hex.pm). Other possible dependency sources include the
GitHub repository, a Git repository, or a local folder.

-Running = $mix deps.get 
fetches all dependencies (recursively) and stores the reference 
to the exact version of each dependency in the mix.lock file.  this file is consulted to fetch the proper versions of dependencies. This ensures reproducible builds across different machines, so make sure you include mix.lock in the source control where your project resides.

## Usage
$mix deps.get 
$iex -S mix
>Application.started_applications()
>Application.stop(:todo_poolboy)
>System.stop()