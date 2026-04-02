### Migrating from Gazebo Classic to Harmonic+
- Modern Gazebo is renderer egnostic rather than only supporting OGRE.
- Resource for migrating from Gazebo classic URDF/SDF files: https://gazebosim.org/api/sim/8/migrationsdf.html#:~:text=Materials

### Degugging URDF/XACRO
Projects may seperate the URDF (Universal Robot Description File) into several xacro files for organization. You can use this command to compile all xacro files into a single urdf for debugging: `ros2 run xacro xacro your_main_file.xacro > debug.urdf`

Before Gazebo can read the URDF, it must first convert it to SDF. You can run a command to convert the file to SDF seperatly to test for errors: `gz sdf -p your_robot.urdf`

