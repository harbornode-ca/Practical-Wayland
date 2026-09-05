#!/bin/bash
setupStg=$(cat /opt/kevrevrun/status/setup.stage)
stage1 () {
    echo Downloading initial setup script...
    wget -O /opt/kevrevrun/scripts/01-script.sh https://raw.githubusercontent.com/harbornode-ca/Practical-Wayland/refs/heads/main/scripts/01-script.sh
    echo Making script executable...
    chmod +x /opt/kevrevrun/scripts/01-script.sh
    echo Starting initial setup script...
    /opt/kevrevrun/scripts/01-script.sh
}
stage2 () {
    echo Update stage
}
case $setupStg in 
    "0")
    stage1
        ;;
    "1")
    stage2
        ;;    
esac