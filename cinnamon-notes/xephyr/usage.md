# Using Xephyr

### Install

- Install on debian-based distros with `apt install xserver-xephyr`

### Cinnamon usage example

- Start a Xephyr server:
    - `Xephyr -br -ac -noreset -screen 1024x768 :1 &`
- Launch Cinnamon in server:
    - `DISPLAY=:1 cinnamon`
