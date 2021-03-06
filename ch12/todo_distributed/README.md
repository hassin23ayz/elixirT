# TodoDistributed

to have a truly reliable system , you need to run it on multiple machines 
you can send a message to another process regardless of whether it's running in the same BEAM instance or 
on another instance on a remote machine 

A properly designed concurrent system is in many ways ready to be distributed across multiple machines 

iex> is a beam instance
A node is a beam instance that has a name associated with it 
Nodes can be started on the same host machine or on different machines 
Multiple Nodes are connected to form a cluster . 

After the connection is established , each node periodically sends tick message to all of its connected peers
to check whether they're still alive. 
It's possible to register and receive notifications when a node is disconnected 

lambdas that are defined in module functions can be spawned
remotely (or sent to a remote node via a message) only if both nodes are powered by
exactly the same compiled code. These requirements are hard to satisfy if you start running
a multinode cluster and then need to update the code. You can’t simultaneously
upgrade all the nodes in the cluster, so at some point the code on the nodes will differ.
Therefore, it’s generally better to avoid passing lambdas to a remote node. Instead, you
should use the Node.spawn/4 function, which accepts an MFA (module, function, arguments
list) that identifies a function to be invoked on the target node

Process Discovery: 
	Registry is not cluster aware and works only in the scope of a local node
	:global module provides a global name registration facility 

Global Registration can also be used with GenServer 
if a registered process crashes or the owner node disconnects, the alias is automatically
unregistered on all other machines.

Network Partition : A partition is a situation in which a communication channel between 2 nodes is broken and 
the nodes are disconnected. in this case you may end up with a split brain situation 

:global.whereis_name/1 doesn’t lead to any cross-node
chatting. This function only makes a single lookup to a local ETS table.

changes: 
1. Todo.Server Process Global Registration
2. Todo.Server Process Global Lookup 
3. At Todo.Cache usage of || operator to return existing Todo.Server process or create a new Todo.Server process
4. Removal of Process Registry
5. Database Store operation changed to GenServer Call type 
6. Node prefixed Database folder naming 
7. replicated database:
	:rpc allows to issue a function call on all nodes in the cluster
	Use of :rpc multicall to store database items to both remote and own node

#usage 
open 2 terminals and cd to this project root 
$ iex --sname node1@localhost -S mix
$ iex --erl "-todo_distributed port 5555" --sname node2@localhost -S mix

node1> Node.connect(:node2@localhost)

open another terminal and operate on node 1 
$ curl -d '' 'http://localhost:5454/add_entry?list=bob&date=2018-12-19&title=Dentist'
self verify (node 1) 
$ curl 'http://localhost:5454/entries?list=bob&date=2018-12-19'

verify at other node (node 2)
$ curl 'http://localhost:5555/entries?list=bob&date=2018-12-19'

crash / stop one Node (node 1)
node1> System.stop()

read from another Node (node 2)
$ curl 'http://localhost:5555/entries?list=bob&date=2018-12-19'

----------------------------------------------------------------------------------------
-You should set up a load balancer to serve as a single access point for all clients.
-You need a scheme for introducing new nodes to the running cluster. When a
new node is introduced, it should first synchronize the database with one of the
already-connected nodes; then it can begin serving requests.

-By using the built-in Mnesia database, you could achieve better write guarantees
and be able to easily migrate new nodes to the cluster.Mnesia
doesn’t deal explicitly with network partitions and split-brain scenarios, and instead
leaves it to the developer to resolve this situation

-When you decide to go distributed, network partitions are a problem you’ll have to deal with,
one way or another.

-A process that calls monitor_nodes will receive notifications
whenever a remote node connects or disconnects

-You can set up a monitor or a link to a remote process.
This works just as it does with local processes. If a remote process crashes (or the
node disconnects), you’ll receive an exit signal (when using links).

-A connection between a long-named node and a short-named node isn’t possible.

-A node running on another machine will have a different cookie, so connecting two nodes on different
machines won’t work by default; you need to somehow make all nodes use the same cookie.
Cookie can be set when you start the system. 

-Helper Nodes can be connected with hidden connection . 
When you want to perform a cluster-wide operation, you should generally use the :visible option
Services provided by :global, :rpc, and :pg2 ignore hidden nodes.

-EPMD knows the names of all currently running BEAM nodes on the machine 