#!/bin/bash
# Setup Variables. Added to every file for consistancy.
MAIN_DIR=/opt/kevrevrun
RUN_DIR=/opt/kevrevrun/status
SCR_DIR=/opt/kevrevrun/scripts
NFO_DIR=/opt/kevrevrun/cfg
DEB_NFO=/opt/kevrevrun/cfg/pkg_lists
TMP_DIR=/opt/kevrevrun/tmp
USR_ID=$(cat $MAIN_DIR/id.usr)
USR_NM=$(cat $MAIN_DIR/name.usr)
IST_DIR=$(cat $MAIN_DIR/install.dir)
STATUS=$RUN_DIR/loop.status
LOOP=$(cat $STATUS)
echo 0 > $CFG_DIR/loop.status
STAGE=$CFG_DIR/setup.stage
STEP=$(cat $STAGE)
CENTER=$(cat $RUN_DIR/center.value)
MARGIN=$(cat $RUN_DIR/margin.value)
LEFT=$(cat $RUN_DIR/left.value)
prt_err () {
gum style --foreground="1" --padding="1 1" "$ERR_MSG"
gum style --foreground="1" --padding="1 1" "Exit Code: $EXIT -  Check failed.log for details"
echo  $RN > $IST_DIR/failed.log
gum style --foreground="208" --padding="1 1" "Exit Code: $EXIT -  Check failed.log for details"
exit 1
}
clear
gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --margin="0 1" --width="$LEFT" "KEVREVRUN's Debian Setup"
gum style --foreground="208" --border-foreground="154" --border="rounded" --align="center" --margin="0 1" --width="$LEFT" "Setup Status Dialog"
read
#Pending Colour: 208
#Sucess Colour: 154
#Failue Colour: 1
gum style --foreground="208" --padding="1 1" "Updating repository cache..."
sleep 1
RN=$(apt update > output.tmp)
EXIT=$?
if [ $EXIT != 0 ]; then
	ERR_MSG="Updating repository cache failed!"
        prt_err
else
        gum style --foreground="154" --padding="1 1" "Repository cache is now up to date"
	sleep 1
fi
gum style --foreground="208" --padding="1 1" "Upgrading to Debian Forky..."
sleep 1
gum style --foreground="208" --padding="1 1" "Checking for available updates..."
RN=$(cat output.tmp | grep -c "packages can be upgraded")
if [ $RN = 1 ]; then
	UPDATES=1
	gum style --foreground="154" --padding="1 1" "There are updates available to install"
	sleep 1
	AVAIL=$(cat output.tmp | grep "packages can be upgraded" | cut -d " " -f 1)
        gum style --foreground="154" --padding="1 1" "There are $AVAIL updates to be installed"
	sleep 1
	gum style --foreground="208" --padding="1 1" "Getting list of updates..."
	sleep 1
	RN=$(sudo apt list --upgradable | sed -e 's/\//,/g' -e 's/ /,/g' -e 's/,\[upgradable,from\:,/,/g' -e 's/\]//g' | grep -v "Listing..." > output.tmp)
	EXIT=$?
	if [ $EXIT != 0 ]; then
	        ERR_MSG="Failed retrieving update list"
       		prt_err
	fi
	gum style --foreground="154" --padding="1 1" "Sucessfully generated update list..."
	sleep 1
	gum style --foreground="154" --padding="1 1" "Listing available updates"
	cat output.tmp | awk -f /opt/kevrevrun/config/aptlist.awk -F "," | gum style --foreground="220" --padding="0 1"
	EXIT=$?
	if [ $EXIT != 0 ]; then
		RN="Failed to process output.tmp"
	        ERR_MSG="Failed downloading updates"
       		prt_err
	fi
	gum style --foreground="208" --padding="1 1" "Downloading updates..."
	RN=$(apt upgrade -d -y)
	EXIT=$?
	if [ $EXIT != 0 ]; then
	        ERR_MSG="Failed downloading updates"
       		prt_err
	fi
	gum style --foreground="154" --padding="1 1" "Updates sucessfully downloaded"
	sleep 1
	gum style --foreground="208" --padding="1 1" "Installing Updates..."
	RN=$(apt upgrade -y)
	EXIT=$?
	if [ $EXIT != 0 ]; then
	        ERR_MSG="Failed installing updates"
       		prt_err
	fi
	gum style --foreground="154" --padding="1 1" "Updates sucessfully installed"
	sleep 1
else
	gum style --foreground="208" --padding="1 1" "The system is already up to date"
	sleep 1
fi
echo 1 > $STATUS
read
