# TodoHttp
various web server frameworks and libraries are available for both elixir and erlang 
(1) Phoeniex: is a web development framework written in Elixir which implements the server side MVC pattern.
(2) Cowboy: erlang library (lightweight and efficient HTTP server Library)
(3) Plug: provides an unified API that abstracts away the web library

There will be atleast one process that listens on a given port and accept requests . 
Then each distinct TCP connection will be handled in a separate process . these processes have callbacks 
which will be invoked in those request specific processes . 

The Plug and Cowboy applications can be considered factories of HTTP servers.

"Phoeneix is not your Application" = Do not put application specific logic in HTTP parsing based code (Todo.Web) . pass the responsibility to other module 

-Usage
$mix deps.get 
$iex -S mix
>Application.started_applications()

Do not exit from iex terminal let it run 
open a new linux terminal 
$curl -d '' 'http://localhost:5454/add_entry?list=bob&date=2018-12-19&title=Dentist'
$curl 'http://localhost:5454/entries?list=bob&date=2018-12-19'

>Application.stop(:todo_http)
>System.stop()

-Benchmark
--wrk install
$git clone https://github.com/wg/wrk
$sudo apt-get install make
$make -j8
$sudo apt-get install gcc
$sudo apt-get update
$sudo apt-get install gcc
$make -j8
$make WITH_LUAJIT=/usr WITH_OPENSSL=/usr
$sudo cp wrk /usr/local/bin

-Testing
$wrk -t12 -c400 -d30s 'http://localhost:5454/add_entry?list=bob&date=2018-12-19&title=Dentist'
$wrk -t12 -c400 -d30s 'http://localhost:5454/entries?list=bob&date=2018-12-19'

Cast operations are fire and forget type 
Call operations promotes consistency but reduces responsiveness of the system 

Keeping call operations , we can introduce a new process in between. this process will add the request to it's queue and reply will be send immediately . Later when the added requests gets processed a subsequent notification will be sent back . 
this way system becomes both responsive and consistent 

- if more complex load management is desired then GenStage can be used 


