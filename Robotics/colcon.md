### Building packages
1. Setup your shell for ros2 with `source /opt/ros/jazzy/setup.bash`
2. From within the project directory, create a folder named `src/`
3. From the root of the project(one dir above `src/`); run `colcon build --symlink-install`
4. After packages are built, update your shell with `source install/setup.bash`