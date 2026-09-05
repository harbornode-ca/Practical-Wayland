#!/bin/bash
# Confirms and creates initial directories if missing.
for folder in "cfg" "status" "scripts" "tmp" "logs" "cfg/pkg_lists"; do
    if [ ! -d "/opt/kevrevrun/$folder" ]; then
        mkdir -v /opt/kevrevrun/$folder
    fi
done
for folder in "cfg" "status" "scripts" "tmp" "logs" "cfg/pkg_lists"; do
    if [ ! -d "/opt/kevrevrun/$folder" ]; then
        echo "Error: Directory $folder not found"  
        exit 1
    else
        echo "Directory $folder found"
    fi
done
# Creates a file that contains all folder used in the installation
cat << 'EOF' > /opt/kevrevrun/status/folders.list
mainDir,/opt/kevrevrun
statusDir,/opt/kevrevrun/status
scriptDir,/opt/kevrevrun/scripts
cfgDir,/opt/kevrevrun/cfg
aptDir,/opt/kevrevrun/cfg/pkg_lists
tmpDir,/opt/kevrevrun/tmp
logDir,/opt/kevrevrun/logs
EOF
# Sets the folder variables for each folder in folders.list
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    echo "Variable Name: $varName"
    varValue=$(echo $f | cut -d ',' -f 2)
    echo "Variable Value: $varValue"
    export $varName="$varValue" 2>&1
done
# Creates file that contains all files that hold a status across scripts and reboots.
cat << 'EOF' > /opt/kevrevrun/status/files.list
stageFile,/opt/kevrevrun/setup.stage
statusFile,/opt/kevrevrun/status/loop.status
mainLog,/opt/kevrevrun/logs/main.log
EOF
# Sets variables for the status files
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    echo "Variable Name: $varName"
    varValue=$(echo $v | cut -d ',' -f 2)
    echo "Variable Value: $varValue"
    export $varName="$varValue"
done
# Creates a file that allows the saved variables to be called into the current script
cat << 'EOF' > /opt/kevrevrun/status/values.list
loopStat,/opt/kevrevrun/status/loop.status
nowStep,/opt/kevrevrun/setup.stage
usrId,/opt/kevrevrun/id.usr
usrName,/opt/kevrevrun/name.usr
setupDir,/opt/kevrevrun/install.dir
EOF
# Reads the values from the files in values.list
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    echo "Variable Name: $varName"
    fileName=$(echo $v | cut -d ',' -f 2)
    echo "File Name: $fileName"
    varValue=$(cat $fileName)
    echo "Variable Value: $varValue"
    export $varName="$varValue"
done
#Checks if temporary directory exists and is empty
wget -O $tmpDir/practical-wayland.zip https://github.com/harbornode-ca/Practical-Wayland/archive/refs/heads/main.zip
if [ -f $tmpDir/practical-wayland.zip ]; then
    unzip $tmpDir/practical-wayland.zip
fi
#Move files from the installation directory to Main directory
destFldr="$statusDir $scriptDir $cfgDir"
for f in $destFldr; do
    echo $f
    rm -rvf $f/*
done
destFldr="$statusDir $scriptDir $cfgDir"
for f in $destFldr; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    echo $srcFldr
    cp -Rv ./Practical-Wayland-main/$srcFldr/* $f
done
#Cleaning up Practical Wayland files
rm -fv $tmpDir/practical-wayland.zip
rm -rvf $setupDir/Practical-Wayland-main