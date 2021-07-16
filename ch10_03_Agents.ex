# if a GenServer-powered module implements only init/1,
# handle_cast/2, and handle_call/3, it can be replaced with an Agent.

# Agent.start_link() starts a new process
# in the process the lamda is called
# unlike Task, Agent does not terminate when lamda gets executed
# the return value becomes the state of the Agent
{:ok, pid} = Agent.start_link(fn -> %{name: "Bob", age: 30} end)

# Agent.get() takes the pid of the Agent and a lamda
# As argument , Agent's state gets passed
# The lamda gets executed in the Agent's process
# The return value of the lamda is sent back to the caller process as a msg
name = Agent.get(pid, fn state -> state.name end)
IO.inspect(name)

# As argument, Agent's state gets passed
Agent.update(pid, fn state -> %{state | age: state.age + 1} end)
age = Agent.get(pid, fn state -> state.age end)
IO.inspect(age)

# A single agent, being a process, can be used by multiple client processes. A change
# made by one process can be observed by other processes in subsequent agent operations.
{:ok, counter} = Agent.start_link(fn -> 0 end)
spawn(fn -> Agent.update(counter, fn count -> count + 1 end) end)
Process.sleep(1)
IO.inspect(Agent.get(counter, fn count -> count end))
