
## TIPS:
- It is wise to delay the spawn of the robot to give Gazebo time to load the world first.(prevents crashes)

### Sim-Time
- This an alternative simulated clock to follow rather than the host computers hardware clock.
- This improves synchronization between components in case some simulate slower or faster than real world time.

### Ros Container Composition
- This allows for grouping of processes into one.

### RSP (Robot State Publisher)
- Takes URDF File and publishes the TF (Transform) Tree.

### Gazebo Server
- This is the physics engine of the simulation.

