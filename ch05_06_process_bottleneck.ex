# module starts with Capital letter
defmodule Server do
  # this is a public function
  def start do
    # start the process . it returns the pid of the process
    spawn(fn -> loop() end)
  end

  # public function receiving data from it's client/user code
  # The function send_msg() is called by clients and runs in a client process
  def send_msg(server, message) do
    # send data to the process by referring the pid as arg1 but do send own pid as self() so that it can listen in turn
    send(server, {self(), message})
    # right after send start listening
    receive do
      # a case with pattern matching , there can be multiple cases [switch case alike]
      {:response, response} -> response
    end
    #self()
  end

  # this is private functiom
  # The private function loop/0 runs in the server process.
  defp loop do
    receive do
      # a case with pattern matching , there can be multiple cases [switch case alike]
      {caller, msg} ->
        Process.sleep(1000)
        send(caller, {:response, msg})
    end
    # recursive call so that it can listen for incoming msg again
    loop()
  end
end

# usage to show pid differences
IO.inspect(self())                          # will print client(this) process pid
pid = Server.start()
IO.inspect(pid)                             # will print Server(loop/0 def of the module) process pid
# enable 19 line to see the returned pid
# IO.inspect(Server.send_msg(pid, :foo))      # will print client(this) process pid

# usage bottleneck
# Disable 19 line to make following code work
# responses will pe printed slowly
server = Server.start()
Enum.each( 1..5, fn i -> spawn(fn ->
                          IO.puts("Sending msg ##{i}")
                          response = Server.send_msg(server, i)
                          IO.puts("Response: #{response}")
                          end)
                  end
)
