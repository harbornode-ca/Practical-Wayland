#!/bin/bash
# Creates a file that contains all folder used in the installation
"cfg" "status" "scripts" "tmp" "logs" "cfg/pkg_lists"
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
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue"
done
# Creates file that contains all files that hold a status across scripts and reboots.
cat << 'EOF' > /opt/kevrevrun/status/files.list
stageFile,/opt/kevrevrun/status/setup.stage
statusFile,/opt/kevrevrun/status/loop.status
mainLog,/opt/kevrevrun/logs/main.log
EOF
# Sets variables for the status files
varFiles=$(cat /opt/kevrevrun/status/files.list)
for f in $varFiles; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue"
done
# Creates a file that allows the saved variables to be called into the current script
cat << 'EOF' > /opt/kevrevrun/status/values.list
loopStat,/opt/kevrevrun/status/loop.status
nowStep,/opt/kevrevrun/status/setup.stage
usrId,/opt/kevrevrun/id.usr
usrName,/opt/kevrevrun/name.usr
setupDir,/opt/kevrevrun/install.dir
EOF
# Reads the values from the files in values.list
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
    gum style --foreground="208" "Exported $varName with value $varValue"
	logMsg=$(echo $v)
done
# Checks if temporary directory exists and is empty
if [ -d $mainDir ]; then
    if [ -d "$tmpDir" ]; then
	    tmpList=$(ls "$tmpDir"| wc -l)
        if [ $tmpList > 0 ]; then
		rm -fv $tmpDir/*
	    fi
    else
        mkdir -pv $tmpDir\
    fi
else
    mkdir 
fi
