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
title () {
gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --margin="$MARGIN" --width="$CENTER" "KEVREVRUN"
cat title.tmp | gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --padding="0 0" --margin="$MARGIN" --width="$CENTER"
}
clear
title
gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --margin="0 0" --width="$LEFT" "Initializing Setup"
gum style --foreground="208" --margin="0 1" "We need to get things organized!"
gum style --foreground="208" --margin="0 1" "Downloading files, creating folders, moving around files and setting permissions"
gum style --foreground="208" --margin="1 1" "Press Enter when you are ready to continue..."
read -p " "
tmux send-keys -t root:0.1 Enter
gum spin --spinner="dot" --spinner.foreground="208" --title.foreground="154" --title="Updating system..." $IST_DIR/00-crew.sh
tmux send-keys -t root:0.1 Enter
gum spin --spinner="dot" --spinner.foreground="208" --title.foreground="154" --title="Updating system..." $IST_DIR/00-crew.sh
gum style --foreground="154" --margin="1 1" "Stage Complete!"
gum style --foreground="208" --margin="1 1" "Press Enter when you are ready to continue..."
read
tmux detach-client
