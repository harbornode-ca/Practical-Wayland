#!/bin/bash
# Adds Debian Forky repositories and updates system to Debian Forky.
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue" 2>&1
done
# Sets the variables for the status files
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    export $varName="$varValue"
done
# Reads the values from the files in values.list
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
done
oldRepos=$(find /etc/apt -name "sources.list*" -not -regex ".*/sources.list.d.*")
for r in $oldRepos; do
    rm -fv $r
done
srcList=$(ls /etc/apt/sources.list.d | grep -c . 2>&1)
if [ $srcList -gt 0 ]; then
    fileList=$(ls /etc/apt/sources.list.d)
    for f in $fileList; do
        rm -fv "/etc/apt/sources.list.d/$f"
    done
fi
cp -fv "$cfgDir/apt-files/enabledForky.sources" "/etc/apt/sources.list.d/forky.sources"
apt update 2>&1 > output.tmp
chkUpgrades=$(cat output.tmp | grep -c "packages can be upgraded")
numUpdates=$(cat output.tmp | grep "packages can be upgraded" | cut -d ' ' -f 1)
if [ $chkUpgrades != 0 ]; then
    echo "There are $numUpdates upgrades available..."
    echo "Installing upgrades"
    sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
else
    echo "System already up to date..."
    echo
    echo "No updates available..."
fi
echo "Upgrade process completed!"
echo 2 > $stageFile
echo "The system requires reboot!"
echo
echo "Rebooting in 10 seconds..."
sleep 5
echo "Rebooting in 5 seconds..."
sleep 5
echo "Rebooting now!"
#reboot