#!/bin/bash
setupStg=$(cat /opt/kevrevrun/status/setup.stage)
stage1 () {
echo "Placeholder"
}
stage2 () {
echo "Placeholder"
}
case $setupStg in
    "0")
    stage1
        ;;
    "1")
    stage2
        ;;
    *)
    wget -O/opt/kevrevrun/scripts/01-script.sh https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/01-script.sh
    chmod +x /opt/kevrevrun/scripts/01-script.sh
    /opt/kevrevrun/scripts/01-script.sh
esac
