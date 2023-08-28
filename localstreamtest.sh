#!/bin/bash
# localstreamtest.sh (script name)

source main.sh

# Associative arrays for applications with positioning data

declare -A RTMPTop=(
    ["app_name"]="xfce4-terminal"
    ["window_name"]="RTMPTop"
    ["top_x"]=300
    ["top_y"]=0
    ["width"]=300
    ["height"]=400
    ["command"]="top"
)

declare -A RTMPTcpdumb=(
    ["app_name"]="xfce4-terminal"
    ["window_name"]="RTMPTcpdumb"
    ["top_x"]=600
    ["top_y"]=0
    ["width"]=300
    ["height"]=400
    ["command"]="tcpdump -i enp3s0 -nn -X 'port 1935'"
)

declare -A RTMPErrorLog=(
    ["app_name"]="xfce4-terminal"
    ["window_name"]="RTMPErrorLog"
    ["top_x"]=900
    ["top_y"]=0
    ["width"]=300
    ["height"]=400
    ["command"]="tail -n50 -F /var/log/nginx/error.log"
)

declare -A RTMPAccessLog=(
    ["app_name"]="xfce4-terminal"
    ["window_name"]="RTMPAccessLog"
    ["top_x"]=1200
    ["top_y"]=0
    ["width"]=300
    ["height"]=400
    ["command"]="tail -n50 -F /var/log/nginx/access.log"
)


declare -A OBS=(
    ["app_name"]="obs-studio"
    ["window_name"]="obs"
    ["top_x"]=0
    ["top_y"]=450
    ["width"]=1920
    ["height"]=630
    ["command"]="None"
)

  

# Main
proceed_application RTMPTop
proceed_application RTMPTcpdumb
proceed_application RTMPErrorLog
proceed_application RTMPAccessLog
proceed_application OBS
