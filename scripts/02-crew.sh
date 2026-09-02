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
read
DIRS="/opt/kevrevrun /opt/kevrevrun/status /opt/kevrevrun/scripts /opt/kevrevrun/cfg /opt/kevrevrun/cfg/pkg_lists /opt/kevrevrun/tmp"
for d in $DIRS; do
		gum style --foreground="208" --margin="0 1" "Checking for directory:"
		gum style --foreground="208" --margin="0 1" "$d"
		echo
	if [ -d $d ]; then
		gum style --foreground="154" --margin="0 1" "Directory already exists"
		gum style --foreground="208" --margin="0 1" "Skipping directory creation"
		gum style --foreground="184" --margin="1 1" --strikethrough "           "
		sleep 1
	else
		gum style --foreground="208" --margin="0 1" "Directory missing..."
		gum style --foreground="208" --margin="0 1" "Creating directory..."
		RN=$(mkdir $d)
		if [ -d $d ]; then
		gum style --foreground="154" --margin="0 1" "Directory $d created"
		sleep 1
		gum style --foreground="184" --margin="1 1" --strikethrough "           "
		else
		gum style --foreground="208" --margin="0 1" "Failed creating directory..."
		ERR_MSG="Directory creation failed"
		prt_err
		sleep 1
		fi
	fi
done
gum style --foreground="208" --margin="0 1" "Verified directories Sucessfully"
sleep 1
RN=$(wget -o /opt/kevrevrun/tmp/Practical-Wayland.zip -O /opt/kevrevrun/tmp/wget.log https://github.com/harbornode-ca/Practical-Wayland/archive/refs/heads/main.zip)
EXIT=$?
if [ $EXIT != 0 ]; then
	ERR_MSG="Practical-Wayland.zip download failed"
	prt_err
fi
if [ ! -d $TMP_DIR/Practical-Wayland.zip ]; then
	ERR_MSG="Practical-Wayland.zip download failed"
	prt_err
fi
RN=$(unzip $TMP_DIR/Practical-Wayland.zip -d $IST_DIR/)
# Add functionality:
# 1. Download files
# 2. Organize files
# 3. Confirm configuration
# 4. Hand off to system update.