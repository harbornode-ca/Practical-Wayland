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
cat << EOF > title.txt
-PRESENTS-
Practical Debian Wayland Environments
Install Script
EOF
declare -i WIDTH=0 CENTER=0 LEFT=0
let x=$COLUMNS y=4 z=x-y
WIDTH=$z
let x=$COLUMNS y=3 z=x/y
CTRWIDTH=$z
let x=$CTRWIDTH y=3 z=x-y
CENTER=$z
echo $CENTER > $CFG_DIR/center.value
MARGIN="0 $z"
echo $MARGIN > $CFG_DIR/margin.value
let x=$COLUMNS y=4  z=x/4
LEFT=$z
echo $LEFT > $CFG_DIR/left.value
title () {
gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --margin="$MARGIN" --width="$CENTER" "KEVREVRUN"
cat title.tmp | gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --padding="0 0" --margin="$MARGIN" --width="$CENTER"
}
prt_err () {
gum style --foreground="1" --padding="1 1" "$ERR_MSG"
gum style --foreground="208" --padding="1 1" "Exit Code: $EXIT -  Check failed.log for details"
echo  $RN > "$IST_DIR/failed.log"
gum style --foreground="208" --padding="1 1" "Command output written to failed.log"
gum style --foreground="154" --padding="1 1" "This script will now exit"
sleep 2
exit 1
}
invalid () {
gum style --foreground="1" --padding="1 1" "  INVAILD RESPONSE ENTERED!"
gum style --foreground="208" --padding="1 1" "  Please enter a vailid response..."
gum input --placeholder=" " --prompt=" Press Enter to retry..." --prompt.foreground="154" --cursor.foreground="208" --no-show-help --padding="1 1"
}
first_run () {
RN=$(tmux new -s user -d -c $IST_DIR)
RN=$(sudo tmux new -s root -d -c $IST_DIR)
RN=$(tmux split-window -v -p 70 -t user:0)
RN=$(sudo tmux split-window -v -p 70 -t root:0)
clear
title
gum style --foreground="208" --bold --margin="1 1" "Welcome to KEVREVRUN's Wayland Environments Installer"
gum style --foreground="184" --margin="0 1" "This installer will need to be run multiple times. Unfortunately not everything can be done without restarts."
gum style --foreground="184" --margin="0 1" "When the system restarts simply re-run this script and it will automatically pick up right where you left off."
gum style --foreground="184" --margin="0 1" "Most of the installation will happen in a tmux window. There will be a pane on top that directs the install"
gum style --foreground="184" --margin="0 1" "and enages with the user. The bottom pane will provide detailed feedback on what is happening with the"
gum style --foreground="184" --margin="0 1" "install process giving feedback on the progress of the setup."
sudo tmux send-keys -t root:0.0 "$IST_DIR/01-crew.sh" Enter
sudo tmux send-keys -t root:0.1 "$IST_DIR/02-crew.sh" Enter
gum style --foreground="154" --margin="1 1" "Press Enter when you are ready to continue..."
read -p " "
sudo tmux attach -t root:0.0
#tmux kill-server
#sudo tmux kill-server
}
first_run
clear
title
read -p ""
