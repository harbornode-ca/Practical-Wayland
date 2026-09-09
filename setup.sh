#!/bin/bash
setupStg=$(cat /opt/kevrevrun/status/setup.stage)
stage1 () {
    echo "Beginning stage 1 of the install process"
    echo
    echo "Retrieving stage 1 script..."
    echo
    wget -nv -O /opt/kevrevrun/scripts/01-script.sh https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/01-script.sh
    if [ -f /opt/kevrevrun/scripts/01-script.sh ]; then
        echo "Script retrieved successfully."
        sleep 0.5
        chmod -v +x /opt/kevrevrun/scripts/01-script.sh
        echo "Running script..."
        sleep 0.5
        /opt/kevrevrun/scripts/01-script.sh
    else
        echo "Script retrieval failed."
        read -p "Press [Enter] key to exit..."
        exit 1
    fi
}
stage2 () {
    echo "Beginning stage 2 of the install process"
    sleep 1
    echo
    echo "Running stage 2 script..."
    sleep 0.5
    echo
    sudo /opt/kevrevrun/scripts/02-script.sh
}
stage3 () {
    echo "Beginning stage 3 of the install process"
    sleep 1
    echo
    echo "Running stage 3 script..."
    sleep 0.5
    echo
    /opt/kevrevrun/scripts/03-script.sh
}
case $setupStg in
    "0")
    stage1
        ;;
    "1")
    stage2
        ;;
    "2")
    stage3
        ;;
    *)
    echo "The setup.stage file is corrupted."
esac
