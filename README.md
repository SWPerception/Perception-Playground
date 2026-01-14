# Perception-Playground

This repo is set up as a ROS 2 `colcon` workspace (packages live in `src/`).

## Quick start (recommended: VS Code devcontainer)
This repo ships with a VS Code devcontainer that uses a prebuilt Docker image (`lichunho00/perception_playground`) with **ROS 2 Jazzy + Nav2** already installed. A lightweight desktop is exposed locally via VNC/noVNC so you can run GUI tools (RViz/Gazebo) without host-side ROS setup.

1. Install Docker Desktop + VS Code + the “Dev Containers” extension.
2. Open this repo in VS Code.
3. Run: “Dev Containers: Reopen in Container”.
4. Once the container finishes starting, open the GUI (choose one):
   - Browser (noVNC): `http://localhost:6080/vnc.html`
   - macOS (recommended): install TigerVNC Viewer (https://tigervnc.org/), then connect to `localhost:5901` (no password)

The VNC server is started automatically by the devcontainer (`postStartCommand`), but you can also run it manually inside the container:

```bash
start-vnc.sh
```

## Run the Nav2 Turtlebot3 simulation
In the container terminal:

```bash
export ROS_DISTRO=${ROS_DISTRO:-jazzy}
source /opt/ros/$ROS_DISTRO/setup.bash
ros2 launch nav2_bringup tb3_simulation_launch.py headless:=False
```

If Nav2 does not autostart, click the “Startup” button in RViz.

After you’re in the devcontainer, verify Nav2 is available:

```bash
source /opt/ros/$ROS_DISTRO/setup.bash
ros2 pkg list | grep -E '^nav2_|^navigation2$'
```

## Troubleshooting
- If `http://localhost:6080/vnc.html` doesn’t load, check VS Code’s “Ports” panel and ensure `6080` is forwarded.
- If a native VNC client can’t connect, ensure port `5901` is forwarded, then connect to `localhost:5901`.
- If you stop the VNC services inside the container, restart them with `start-vnc.sh`.

## Repo layout
- `src/perception_playground/`: minimal ROS 2 package placeholder
- `scripts/`: helper scripts for rosdep + colcon
- `.devcontainer/`: devcontainer config (prebuilt image + VNC/noVNC)
