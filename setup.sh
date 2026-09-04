#!/bin/bash

# ******************************
# * Start Initial setup section*
# ******************************
clear
gum style --foreground="184" --margin="1 1" --strikethrough "           "
gum style --foreground="208" "Starting Kevrevrun's Wayland Environments Installer..."
echo "Starting Logging of KEVREVRUN's Wayland Environments Installer" > log.tmp
# Making sure correct file permission for /opt/kevrevrun
chmod -Rv 775 /opt/kevrevrun >> log.tmp
sleep 1
gum style --foreground="184" --margin="1 1" --strikethrough "           "
gum style --foreground="208" --padding="0 0" "Loading setup variables..."
gum style --foreground="184" --margin="1 1" --strikethrough "           "
sleep 1

# Creating folders.list for pulling variables in other scripts
# START: Creating folders.list
cat << 'EOF' > /opt/kevrevrun/status/folders.list
mainDir,/opt/kevrevrun
statusDir,/opt/kevrevrun/status
scriptDir,/opt/kevrevrun/scripts
cfgDir,/opt/kevrevrun/cfg
aptDir,/opt/kevrevrun/cfg/pkg_lists
tmpDir,/opt/kevrevrun/tmp
logDir,/opt/kevrevrun/logs
EOF
# END: Creating folders.list

echo "File /opt/kevrevrun/status/folders.list has been created" >> log.tmp

# Exporting folders.list variables to current script
# START: Creating folders.list
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue"
    gum style --foreground="208"  "Exported $varName with value $varValue"
	echo "Exported Variable $varName with the Value $varValue" >> log.tmp
	logMsg=$(echo $f)
done
# END: Creating folders.list

# Renaming previous log files.
# START: Renaming old log files
nowDate=$(date +'%Y-%m-%d-%H-%M' --utc)
if [ -f "$logDir/main.log" ]; then
	echo "Previous log file exists. Renaming previous main.log file" >> log.tmp
	mv -v "$logDir/main.log" "$logDir/$nowDate-main.log" >> log.tmp
fi
# END: Renaming old log files

# Setting up information logging function
# START: Info logging function
infoLog () {
gum log --formatter="logfmt" --level="info" --time="rfc3339" --file="$logDir/main.log" "$logMsg"
}
# END: Info logging function

# First log message
logMsg="Staring log for KEVREVRUN's Debian Installer"
infoLog

# Adds tmp.log to current logfile
# START: Logging log.tmp
while IFS= read -r tmpLog; do
	printf  -v logMsg '%s' "$tmpLog"
	infoLog
done < log.tmp
# END: Logging log.tmp

# Creating files.list for pulling variables in other scripts
# START: Creating files.list
cat << 'EOF' > /opt/kevrevrun/status/files.list
stageFile,/opt/kevrevrun/status/setup.stage
statusFile,/opt/kevrevrun/status/loop.status
mainLog,/opt/kevrevrun/logs/main.log
EOF
# END: Creating files.list

logMsg="File /opt/kevrevrun/status/files.list created"
infoLog

# Exporting folders.list variables to current script
# START: Creating folders.list
varFiles=$(cat /opt/kevrevrun/status/files.list)
for f in $varFiles; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue"
    gum style --foreground="208" "Exported $varName with value $varValue"
	logMsg=$(echo $f)
done
# END: Creating folders.list

# Creating values.list for pulling variables in other scripts
# START: Creating values.list
cat << 'EOF' > /opt/kevrevrun/status/values.list
loopStat,/opt/kevrevrun/status/loop.status
nowStep,/opt/kevrevrun/status/setup.stage
usrId,/opt/kevrevrun/id.usr
usrName,/opt/kevrevrun/name.usr
setupDir,/opt/kevrevrun/install.dir
EOF
# END: Creating values.list

logMsg="File /opt/kevrevrun/status/values.list created"
infoLog

# Exporting values.list variables to current script
# START: Creating values.list
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
    gum style --foreground="208" "Exported $varName with value $varValue"
	logMsg=$(echo $v)
done
# END: Creating values.list

gum style --foreground="184" --margin="1 1" --strikethrough "           "
gum style --foreground="154" "Completed loading setup variables!"
logMsg="All variable completed loading"
infoLog
#gum style --foreground="208" --padding="0 0" "Press Enter to continue..."
#read

# ****************************
# * End initial setup section*
# ****************************
# ---
# *************************
# *Functions Section Start*
# *************************

gum style --foreground="208" --padding="0 0" "Initalizing setup..."
#Creating title.tmp for multiline textbox
cat <<EOF > title.tmp
-PRESENTS-
Practical Debian Wayland Environments
Install Script
EOF

gum style --foreground="208" "Calculating screen dimensions"
# START: Math for text box sizes.
declare -i scrWidth=0 scrCenter=0 scrLeft=0
let x=$COLUMNS y=4 z=x-y
scrWidth=$z
let x=$COLUMNS y=3 z=x/y
scrThird=$z
let x=$scrThird y=3 z=x-y
scrCenter=$z
echo $scrCenter > $cfgDir/center.value
scrMargin="0 $z"
echo $scrMargin > $cfgDir/margin.value
let x=$COLUMNS y=4  z=x/4
scrLeft=$z
echo $scrLeft > $cfgDir/left.value
# END: Math for text box sizes
gum style --foreground="154" "Completed calculations for onscreen elements"
echo
gum style --foreground="208" "Adding essential functions"
# START: Title function
title () {
gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --margin="$scrMargin" --width="$scrCenter" "KEVREVRUN"
cat title.tmp | gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --padding="0 0" --margin="$scrMargin" --width="$scrCenter"
}
# END: Title function

# START: Print error function
prtErr () {
gum style --foreground="208"  "Exit Code: $exitCode, Check log for details"
gum style --foreground="1"  "$errMsg"
gum log --formatter="logfmt" --level="error" --time="rfc3339" --file="$logDir/main.log"  "Exit Code: $exitCode"
gum log --formatter="logfmt" --level="error" --time="rfc3339" --file="$logDir/main.log"  "$errMsg"
gum style --foreground="154" --padding="1 0" "This script will now exit"
sleep 2
exit 1
}
# END: Title Function

# START: Invalid response function
invalid () {
gum style --foreground="1"  "  INVAILD RESPONSE ENTERED!"
gum style --foreground="208"  "  Please enter a vailid response..."
gum input --placeholder=" " --prompt=" Press Enter to retry..." --prompt.foreground="154" --cursor.foreground="208" --no-show-help --padding="1 0"
}
# END: Invalid response function
gum style --foreground="208" "Completed loading functions"
echo
gum style --foreground="154" --padding="1 0" "Completed initializing setup!"
gum style --foreground="184" --margin="1 1" --strikethrough "           "

# ***********************
# *Functions Section End*
# ***********************
# ---
# ***********************
# *Checking System Start*
# ***********************
title
gum style --foreground="184" --margin="1 1" --strikethrough "           "
gum style --foreground="208" "Checking for if $tmpDir directory exists"
if [ -d "$tmpDir" ]; then
    gum style --foreground="154" "Temporary directory already exists"
	logMsg="Temporary directory already exists"
	infoLog
    gum style --foreground="208" "Skipping directory creation..."
    sleep 1
    gum style --foreground="184" --margin="1 1" --strikethrough "           "
    gum style --foreground="208" "Checking if temporary directory is empty..."
	tmpList=$(ls | wc -l)
    if [ "$(ls -A $tmpDir)" ]; then
		gum style --foreground="208" "Temporary directory already contians files"
		gum style --foreground="208" "Cleaning temporary directory"
		logMsg="Deleting existing files in directory"
		infoLog
		rm -fv $tmpDir/* > "$logMsg"
	    exitCode=$?
		gum style --foreground="154" "Cleaning complete"
		sleep 1
		gum style --foreground="184" --margin="1 1" --strikethrough "           "
    	if [ $exitCode != 0 ]; then
			errMsg="Failed cleaning temporary directory"
			prtErr
	    fi
	else
	    gum style --foreground="208" "Temporary directory is already empty"
	    gum style --foreground="154" "Continuing setup..."
	    gum style --foreground="184" --margin="1 1" --strikethrough "           "
	fi
else
    gum style --foreground="208" "Temporary directory does not exist"
	gum style --foreground="208" "Creating temporary directory $tmpDir"
    mkdir -pv $tmpDir >> $logMsg
    exitCode=$?
    infoLog
	if [ $exitCode != 0 ]; then
		errMsg="Failed to create directory $tmpDir"
		prtErr
    fi
    gum style --foreground="154" "Temporary directory $tmpDir created"
    gum style --foreground="184" --margin="1 1" --strikethrough "           "
fi

# START: Reading folders.list
gum style --foreground="208" "Confirming folder setup..."
gum style --foreground="184" --margin="1 1" --strikethrough "           "
#$mainDir $statusDir $scriptDir $cfgDir $aptDir $tmpDir $logDir
chkFldr=$(cat $statusDir/folders.list | cut -d ',' -f 2)
for f in $chkFldr; do
		gum style --foreground="208" --padding="0 0" "Checking for folder $f"
	if [ -d $f ]; then
		gum style --foreground="154" --padding="0 0" "The folder $f is present"
		logMsg="Folder $f is present"
		infoLog
	else
		gum style --foreground="208" --padding="0 0" "The folder $f is not present"
		gum style --foreground="208" --padding="0 0" "Creating folder"
	    mkdir -pv $tmpDir >> $logMsg
		exitCode=$?
		if [ $exitCode != 0 ]; then
			errMsg="Failed to create directory $f"
			prtErr
    	fi
		gum style --foreground="154" --padding="0 0" "Created folder $f"
	fi
done
gum style --foreground="184" --margin="1 1" --strikethrough "           "
gum style --foreground="208" "Downloading Practical Wayland Repository..."
#wget -O $tmpDir/practical-wayland.zip https://github.com/harbornode-ca/Practical-Wayland/archive/refs/heads/main.zip
wget -o $logDir/wget0.log -O $tmpDir/practical-wayland.zip https://github.com/harbornode-ca/Practical-Wayland/archive/refs/heads/main.zip
exitCode=$?
logMsg="wget log saved to wget0.log"
infoLog
if [ $exitCode != 0 ]; then
	errMsg="Failed to download required files"
	prtErr
fi
if [ -f $tmpDir/practical-wayland.zip ]; then
	gum style --foreground="154" "Download suceeded"
fi

cat << 'EOF'
 - Extract zip
 - Create all needed repo files for quickly changing enabled repositories
 - Move files to proper folders
 - Update system - Pass off to other script
 - Options menu for user to choose environment
 - Install Option - Pass off to other script
		- Seperate script for each option
 - Setup theme profiles and dotfiles for each option
 - Setup "preloaded" software
 - Add flatpak support, add repo, set theme
EOF
