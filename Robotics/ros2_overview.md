### Packages in ros

A package contains CmakeList.txt, headers, package.xml for ros programs. The colcon command is used to build these packages.
A package is a unit of software organization; unlike a node which is a unit of execution. *A package can contain many nodes*.

### Nodes in ros

A node is a logical object in ros which is responsible for only one task. Examples of nodes can be motors, sensors, etc. You can list currenlty running nodes using the `ros2 node list` command. You can find information on a node with `ros2 node info <name>`.

### Parameters in ros

- These are key-value pairs used to configure nodes.
- You can list params with `ros2 param list`
- You can get params for a node with `ros2 param get <node_name> <param_name>`
- You can set a param with `ros2 param set <node_name> <param_name> <value>`
- To view a node's current params `ros2 param dump <node_name>`
- To load params from a file `ros2 param load <node_name> <param_file>`

### Message busses for nodes in ros

**Topics**

- Intended for continuous data streams, a node will 'subscribe' to another node's stream of data. The node it subscribed to is noted as the 'publisher'.
- Communication is 1-way.
- Used for many-to-many relationships
- Best used for sensor data, state updates, etc.

**Services**

- Uses a 'request and response' model. This is similar to a 'client server' design.
- This is a one-to-one relationship; one request gets one response.
- Best for standalone actions like: calculate path, take picture, etc.

**Actions**

- These can be thaugh of as 'long term projects with a manager'. This form of communication allows for asynchronous work with long & complex tasks.
- Consists of three parts:
    - Goal (service): client requests to start a task.
    - Feedback (topic): While task runs, server sends periodic updates to client.
    - Result (service): Once task is finished, server sends final report to client.
- Example:
    - An action could be used to tell the robot to drive across the room. While the action is running, in place of waiting for the robot to complete the action, it can perform other tasks while the robot is working.

