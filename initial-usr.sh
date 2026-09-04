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
for folder in "cfg" "status" "scripts" "tmp" "logs" "cfg/pkg_lists"; do
    if [ -d "/opt/kevrevrun/$folder" ]; then
        echo
        echo "Folder /opt/kevrevrun/$folder already exist"
    else
        mkdir -pv /opt/kevrevrun/$folder
        echo "Folder /opt/kevrevrun/$folder created"
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
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue"
    echo
    echo "Exported $varName with value $varValue"
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
    echo
    echo "Exported $varName with value $varValue"
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
    echo
    echo "Exported $varName with value $varValue"
done
# Checks if temporary directory exists and is empty
echo
echo "Checking if temporary directory is empty"
if [ -d "$tmpDir" ]; then
	tmpList=$(ls | wc -l)
    if [ $tmpList > 0 ]; then
        echo
        echo "Temporary directory is not empty, cleaning"
# Remember to change to verbose when adding logging.
        rm -f $tmpDir/*
	    exitCode=$?
	    if [ $exitCode != 0 ]; then
		    errMsg="Failed cleaning temporary directory"
		    prtErr
	    fi
        echo
        echo "Temporary directory cleaned successfully"
	fi
else
    echo
    echo "Temporaty directory does not exist, creating it now"
    mkdir -pv $tmpDir
    exitCode=$?
	if [ $exitCode != 0 ]; then
		errMsg="Failed to create directory $tmpDir"
		prtErr
    fi
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
echo "Unzipping Practical Wayland"
if [ -f $tmpDir/practical-wayland.zip ]; then
	echo
    echo "Practical Wayland Download suceeded"
#Remember to change to verbose when adding logging.    
    unzip -o -qq $tmpDir/practical-wayland.zip
    exitCode=$?
    if [ $exitCode != 0 ]; then
        errMsg="Failed to unzip Practical Wayland"
        prtErr
    fi
fi
# Checks if Practical Wayland folder exists
if [ -d $setupDir/Practical-Wayland-main ]; then
    echo
    echo "Practical Wayland folder exists"
else
    echo
    echo "Practical Wayland folder does not exist"
fi
# Move files from the installation directory to Main directory
destFldr="$statusDir $scriptDir $cfgDir"
for f in $destFldr; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    echo "Confirming empty directories"
    chkEmpty=$(ls $f | wc -l)
    if [ $chkEmpty > 0 ]; then
        echo "$f is not empty, cleaning"
#Remember to change to verbose when adding logging.
        rm -rf $f/*
        exitCode=$?
        if [ $exitCode != 0 ]; then
            errMsg="Failed cleaning directory $f"
            prtErr
        fi
        echo
        echo "Directory $f cleaned successfully"
    else
        echo
        echo "Directory $f is empty"
    fi
    echo
    echo "Moving $srcFldr to $f"
    sudo mv -v $setupDir/Practical-Wayland-main/$srcFldr $f
done
#echo "Moving Practical Wayland contents to $mainDir"
#mv "Practical-Wayland-main/$dirName/" "$"
#exitCode=$?
#if [ $exitCode != 0 ]; then
#    errMsg="Failed to move Practical Wayland contents to $dirName"
#    prtErr
#fi
#echo
#echo "Contents moved to $dirLocation successfully"
#done
echo
echo "Cleaning up Practical Wayland files"
rm -f $tmpDir/practical-wayland.zip
rm -rf $setupDir/Practical-Wayland-main
exitCode=$?
if [ $exitCode != 0 ]; then
    errMsg="Failed to clean up Practical Wayland files"
    prtErr
fi
echo
echo "Practical Wayland files cleaned up successfully"