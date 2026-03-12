# Setup ros2, Gazebo, and Rviz

### Create environment with distrobox
- Create an Ubuntu 24.04 container: `distrobox create -n ros2box -i ubuntu:24.04`
- Enter the environment: `distrobox enter ros2box`

### Ros2 Setup
- Follow ros2 docs to install ros2: [Ros2 Docs](https://docs.ros.org/en/jazzy/index.html)

### Setup the project
- Setup bash environment: `source /opt/ros/jazzy/setup.bash`
- Install project dependancies: `rosdep install -i --from-path src --rosdistro jazzy -y`
- Install project packages with colcon: `colcon build --symlink-install`
- Setup bash environment for project files: `source install/setup.bash`
- Launch project: `ros2 launch [PATH-TO-LAUNCHFILE]`
