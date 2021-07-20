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

----------------------------------------------------------------------------------------------------------
Poolboy usage

1. you pass the desired pool size 
2. you pass the module that powers each worker 

3. <checkOut> other processes can ask the pool manager to give them the pid of one worker 
4. <checkIn>  when the client process does not need the worker process anymore , it notifies the pool manager 

5. Poolboy also relies on monitors and links to detect the termination of a client.
   > if a worker process crashes, a new one will be started
   > If a client checks out a worker and then crashes, the pool manager process will detect it and 
     return the worker to the pool

## Usage 1
$mix deps.get 
$iex -S mix
>Application.started_applications()
>Application.stop(:todo_poolboy)
>System.stop()

## Usage 2 
$iex -S mix
>Application.started_applications()
>Todo.Cache.server_process("ALice")
>Todo.Cache.server_process("Bob")
>:observer.start()
>Application.stop(:todo_poolboy)
>System.stop()