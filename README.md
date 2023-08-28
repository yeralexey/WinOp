# WinOp - Window and Application Organizer

WinOp is a simple shell script that helps you organize and position your terminal windows and applications with ease. Whether you need specific terminals for monitoring or quick access to applications, WinOp can streamline the process for you.

## Dependencies

Before using WinOp, ensure you have the following dependencies installed:

- [xdotool](https://github.com/jordansissel/xdotool): A command-line tool to simulate keyboard input and mouse activity.
- [wmctrl](https://tripie.sweb.cz/utils/wmctrl/): A command-line tool to interact with window managers.


## Configuration

To use WinOp effectively, you'll need to declare your application configurations in a myapp.sh (or any other) file. This file should contain associative arrays for each application you want to manage, specifying their names, window titles, positions, sizes, and commands to execute.

Here's an example of what a myapp.sh file could look like:

```
#!/bin/bash
source main.sh
declare -A MyTerminal=(
    ["app_name"]="xfce4-terminal"
    ["window_name"]="TopTerminal"
    ["top_x"]=300
    ["top_y"]=0
    ["width"]=300
    ["height"]=400
    ["command"]="top"
)
```

This project is licensed under the MIT License.
