#!/bin/bash
echo
echo "---------------------------------------------------------------------------"
echo "|                            *** KEVREVRUN ***                            |"
echo "|                               * Presents *                              |"
echo "|                  In association with Crappy-Bash-Scripts                |"
echo "|                   Practical Debian Wayland Environments                 |"
echo "---------------------------------------------------------------------------"
echo
# Confirms and creates initial directories if missing.
echo "Checking if setup folders status"
sleep 1
echo
for folder in "cfg" "status" "scripts" "tmp" "logs" "cfg/pkg_lists"; do
    if [ -d "/opt/kevrevrun/$folder" ]; then
        echo "Folder /opt/kevrevrun/$folder exists"
    else
        echo "Folder /opt/kevrevrun/$folder does not exist"
        mkdir -p /opt/kevrevrun/$folder
        echo "Folder /opt/kevrevrun/$folder created"
    fi
done
echo
echo "Creating folders.list file"
sleep 1
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
echo "Completed creating folders.list file"
sleep 1
echo
echo "Creating folders variables"
sleep 1
echo
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue"
    echo "Exported $varName with value $varValue"
done
echo
echo "Completed creating folder variables"
sleep 1
echo
echo "Creating files.list file"
sleep 1
# Creates file that contains all files that hold a status across scripts and reboots.
cat << 'EOF' > /opt/kevrevrun/status/files.list
stageFile,/opt/kevrevrun/status/setup.stage
statusFile,/opt/kevrevrun/status/loop.status
mainLog,/opt/kevrevrun/logs/main.log
EOF
echo "Completed creating files.list file"
sleep 1
echo
echo "Creating file variables from files.list"
sleep 1
echo
# Sets variables for the status files
varFiles=$(cat /opt/kevrevrun/status/files.list)
for f in $varFiles; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue"
    echo "Exported $varName with value $varValue"
done
echo "Completed creating file variables"
sleep 1
echo
echo "Creating values.list file"
sleep 1
# Creates a file that allows the saved variables to be called into the current script
cat << 'EOF' > /opt/kevrevrun/status/values.list
loopStat,/opt/kevrevrun/status/loop.status
nowStep,/opt/kevrevrun/status/setup.stage
usrId,/opt/kevrevrun/id.usr
usrName,/opt/kevrevrun/name.usr
setupDir,/opt/kevrevrun/install.dir
EOF
echo "Completed creating values.list file"
sleep 1
echo
echo "Reading and setting variables from values.list"
sleep 1
echo
# Reads the values from the files in values.list
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
    echo "Exported $varName with value $varValue"
done
echo
echo "Completed reading and setting variables"
sleep 1
# Checks if temporary directory exists and is empty
echo
echo "Checking if temporary directory is empty"
if [ -d "$tmpDir" ]; then
	tmpList=$(ls | wc -l)
    if [ $tmpList > 0 ]; then
        echo "Temporary directory is not empty, cleaning"
# Remember to change to verbose when adding logging.
        rm -f $tmpDir/*
	    exitCode=$?
	    if [ $exitCode != 0 ]; then
		    errMsg="Failed cleaning temporary directory"
		    prtErr
	    fi
        echo "Temporary directory cleaned successfully"
	fi
else
    echo "Temporaty directory does not exist, creating it now"
    mkdir -pv $tmpDir
    exitCode=$?
	if [ $exitCode != 0 ]; then
		errMsg="Failed to create directory $tmpDir"
		prtErr
    fi
    echo "Temporary directory created successfully"
fi
echo
echo "Downloading Practical Wayland"
wget -o $logDir/wget0.log -O $tmpDir/practical-wayland.zip https://github.com/harbornode-ca/Practical-Wayland/archive/refs/heads/main.zip
exitCode=$?
if [ $exitCode != 0 ]; then
    errMsg="Failed to download Practical Wayland"
    prtErr
fi
echo
if [ -f $tmpDir/practical-wayland.zip ]; then
    echo "Practical Wayland Download suceeded"
    sleep 1
#Remember to change to verbose when adding logging.    
    echo
    echo "Unzipping Practical Wayland"
    unzip -o -qq $tmpDir/practical-wayland.zip
    exitCode=$?
    if [ $exitCode != 0 ]; then
        errMsg="Failed to unzip Practical Wayland"
        prtErr
    fi
fi
echo "Practical Wayland Suceeded Unzipping"
sleep 1
# Checks if Practical Wayland folder exists
echo
echo "Checking access to Practical Wayland directory"
sleep 1
if [ -d $setupDir/Practical-Wayland-main ]; then
echo "Access to Practical Wayland directory confirmed"
echo
else
    echo "Cannot read Practical Wayland directory"
    exitCode=1
    prtErr
fi
sleep 1
# Move files from the installation directory to Main directory
echo "Moving Practical Wayland to $mainDir"
sleep 1
destFldr="$statusDir $scriptDir $cfgDir"
for f in $destFldr; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    echo
    echo "Confirming empty directory"
    chkEmpty=$(ls $f | wc -l)
    if [ $chkEmpty > 0 ]; then
        echo "The directory $f is not empty, cleaning"
#Remember to change to verbose when adding logging.
        rm -rf $f/*
        exitCode=$?
        if [ $exitCode != 0 ]; then
            errMsg="Failed cleaning directory $f"
            prtErr
        fi
        echo "Directory $f cleaned successfully"
    else
        echo "Directory $f is empty"
    fi
    echo "Moving ./Practical-Wayland-main/$srcFldr to $f"
    mv ./Practical-Wayland-main/$srcFldr $f
    exitCode=$?
    if [ $exitCode != 0 ]; then
        errMsg="Failed to move ./Practical-Wayland-main/$srcFldr to $f"
        prtErr
    fi
    echo "The directory ./Practical-Wayland-main/$srcFldr moved successfully to $f"
done
echo "Practical Wayland moved to $mainDir successfully"
echo
sleep 1
# Cleaning up Practical Wayland files
echo "Cleaning up Practical Wayland files"
sleep 1
rm -f $tmpDir/practical-wayland.zip
rm -rf $setupDir/Practical-Wayland-main
exitCode=$?
if [ $exitCode != 0 ]; then
    errMsg="Failed to clean up Practical Wayland files"
    prtErr
fi
echo "Practical Wayland files cleaned up successfully"
echo
sleep 1
echo "End of Script"
exit 0
