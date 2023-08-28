#!/bin/bash
# main.sh (script name)

function get_application_window_id(){

    local search_word=$1
    local xfce_terminal_mark=$2
    local window_list=()

    
    if [ "$xfce_terminal_mark" == "xfce4-terminal" ]; then
        # if it is xfce-terminal
        while IFS= read -r window_info; do
            window_list+=("$window_info")
        done < <(wmctrl -lx)

        for window_info in "${window_list[@]}"; do
            local window_id=$(echo "$window_info" | awk '{print $1}')
            local window_title=$(xdotool getwindowname "$window_id")
            if [[ "$window_title" == *"$search_word"* ]]; then
                echo "$window_id"
                return
            fi
        done

    else
        # if it is not xfce-terminal
        while IFS= read -r window_info; do
            window_list+=("$window_info")
        done < <(wmctrl -lx)
        
        for window_info in "${window_list[@]}"; do
            local lowercase_window_info=$(echo "$window_info" | tr '[:upper:]' '[:lower:]')
            if [[ $lowercase_window_info == *"$search_word"* ]]; then
                local window_id=$(echo "$window_info" | awk '{print $1}')
                echo "$window_id"
                return 
            fi
        done
    fi
}



function proceed_application() {

    local -n app_array="$1"
    local app_name="${app_array["app_name"]}"
    local app_window_name="${app_array["window_name"]}"
    local app_command="${app_array["command"]}"
    local app_top_x="${app_array["top_x"]}"
    local app_top_y="${app_array["top_y"]}"
    local app_width="${app_array["width"]}"
    local app_height="${app_array["height"]}" 
    local retries=20
    local interval=0.5    
    local window_id=$(get_application_window_id $app_window_name $app_name)

    # If application was not found, open it, and get it's window ID
    if [ -z "$window_id" ]; then
        # Open the application
        if [ "$app_name" == "xfce4-terminal" ]; then
            xfce4-terminal --title="$app_window_name" &
            sleep "$interval"
            xdotool type "$app_command"
            xdotool key Return

        else
            nohup "$app_name" > /dev/null 2>&1 &
        fi

        # Check for the window ID continuously with 0.5-second interval for up to 10 seconds
        while [ $retries -gt 0 ]; do
            window_id=$(get_application_window_id $app_window_name $app_name)
            if [ -n "$window_id" ]; then
                break
            fi
            sleep "$interval"
            retries=$((retries - 1))
        done
    fi

    window_id=$(get_application_window_id $app_window_name $app_name)

    wmctrl -i -r "$window_id" -b remove,_NET_WM_STATE_HIDDEN
    wmctrl -i -r "$window_id" -b remove,_NET_WM_STATE_MINIMIZED
    wmctrl -i -r "$window_id" -b remove,_NET_WM_STATE_FULLSCREEN
    wmctrl -i -r "$window_id" -b remove,maximized_vert
    wmctrl -i -r "$window_id" -b remove,maximized_horz
    wmctrl -i -r "$window_id" -e "0,$app_top_x,$app_top_y,$app_width,$app_height"
    wmctrl -i -a "$window_id"

}