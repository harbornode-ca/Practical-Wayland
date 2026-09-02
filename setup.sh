#!/bin/bash
#Start: Setup Variables
gum style --foreground="208" --padding="1 1" "Loading setup variables..."
cat << 'EOF' > /opt/kevrevrun/status/folders.list
MAIN_DIR,/opt/kevrevrun
RUN_DIR,/opt/kevrevrun/status
SCR_DIR,/opt/kevrevrun/scripts
NFO_DIR,/opt/kevrevrun/cfg
DEB_NFO,/opt/kevrevrun/cfg/pkg_lists
TMP_DIR,/opt/kevrevrun/tmp
LOG_DIR,/opt/kevrevrun/logs
EOF
echo "Starting logging to $LOG_DIR/main.log"
FOLDERS=$(cat /opt/kevrevrun/status/folders.list)
for f in $FOLDERS; do
    VAR_NAME=$(echo $f | cut -d ',' -f 1)
    VAR_VALUE=$(echo $f | cut -d ',' -f 2)
    export $VAR_NAME="$VAR_VALUE"
    gum style --foreground="208" --padding="0 1" "Exported $VAR_NAME with value $VAR_VALUE"
done
cat << 'EOF' > /opt/kevrevrun/status/files.list
STAGE,/opt/kevrevrun/status/setup.stage
STATUS,/opt/kevrevrun/status/loop.status
MAIN_LOG,/opt/kevrevrun/logs/main.log
EOF
FILES=$(cat /opt/kevrevrun/status/files.list)
for f in $FILES; do
    VAR_NAME=$(echo $f | cut -d ',' -f 1)
    VAR_VALUE=$(echo $f | cut -d ',' -f 2)
    export $VAR_NAME="$VAR_VALUE"
    gum style --foreground="208" --padding="0 1" "Exported $VAR_NAME with value $VAR_VALUE"
done
cat << 'EOF' > /opt/kevrevrun/status/values.list
LOOP,/opt/kevrevrun/status/loop.status
STEP,/opt/kevrevrun/status/setup.stage
USR_ID,/opt/kevrevrun/id.usr
USR_NM,/opt/kevrevrun/name.usr
IST_DIR,/opt/kevrevrun/install.dir
EOF
VALUES=$(cat /opt/kevrevrun/status/values.list)
for v in $VALUES; do
    VAR_NAME=$(echo $v | cut -d ',' -f 1)
    FILE=$(echo $v | cut -d ',' -f 2)
    VAR_VALUE=$(cat $FILE)
    export $VAR_NAME="$VAR_VALUE"
    gum style --foreground="208" --padding="0 1" "Exported $VAR_NAME with value $VAR_VALUE"
done
gum style --foreground="154" --padding="1 1" "Setup variables loaded successfully"
cat << EOF > $TMP_DIR/title.tmp
-PRESENTS-
Practical Debian Wayland Environments
Install Script
EOF
#Start: Math for text box sizes.
declare -i WIDTH=0 CENTER=0 LEFT=0
let x=$COLUMNS y=4 z=x-y
WIDTH=$z
let x=$COLUMNS y=3 z=x/y
CTRWIDTH=$z
let x=$CTRWIDTH y=3 z=x-y
CENTER=$z
echo $CENTER > $RUN_DIR/center.value
MARGIN="0 $z"
echo $MARGIN > $RUN_DIR/margin.value
let x=$COLUMNS y=4  z=x/4
LEFT=$z
echo $LEFT > $RUN_DIR/left.value
#End: Math for text box sizes
title () {
gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --margin="$MARGIN" --width="$CENTER" "KEVREVRUN"
cat $TMP_DIR/title.tmp | gum style --foreground="154" --border-foreground="208" --border="rounded" --align="center" --bold --padding="0 0" --margin="$MARGIN" --width="$CENTER"
}
prt_err () {
gum style --foreground="1" --padding="1 1" "$ERR_MSG"
gum style --foreground="208" --padding="1 1" "Exit Code: $EXIT, Check log for details"
gum style --foreground="154" --padding="1 1" "This script will now exit"
sleep 2
exit 1
}
invalid () {
gum style --foreground="1" --padding="1 1" "  INVAILD RESPONSE ENTERED!"
gum style --foreground="208" --padding="1 1" "  Please enter a vailid response..."
gum input --placeholder=" " --prompt=" Press Enter to retry..." --prompt.foreground="154" --cursor.foreground="208" --no-show-help --padding="1 1"
}
gum style --foreground="208" --padding="1 1" "Setting up tmux"
tmux new -s user -d -c "$IST_DIR" 2>&1 >> $MAIN_LOG
EXIT=$?
if [ $EXIT != 0 ]; then
    ERR_MSG="Failed to create *user* tmux sessions" | tee -a $MAIN_LOG
    prt_err
fi
sudo tmux new -s root -d -c "$IST_DIR" 2>&1 >> $MAIN_LOG
EXIT=$?
if [ $EXIT != 0 ]; then
    ERR_MSG="Failed to create *root* tmux sessions" | tee -a $MAIN_LOG
    prt_err
fi
tmux split-window -v -p 70 -t user:0 2>&1 >> $MAIN_LOG
EXIT=$?
if [ $EXIT != 0 ]; then
    ERR_MSG="Failed to send command to tmux session *user*" | tee -a $MAIN_LOG
    prt_err
fi
sudo tmux split-window -v -p 70 -t root:0  2>&1 >> $MAIN_LOG
EXIT=$?
if [ $EXIT != 0 ]; then
    ERR_MSG="Failed to send command to tmux session *root*" | tee -a $MAIN_LOG
    prt_err
fi
sleep 1
gum style --foreground="154" --padding="1 1" "Sucessfully created tmux sessions"
sleep 1
gum style --foreground="184" --margin="1 1" --strikethrough "           "
if [-d "$TMP_DIR" ]; then
    gum style --foreground="154" --padding="1 0" "Temporary directory *$TMP_DIR* already exists"
    gum style --foreground="208" --padding="1 0" "Skipping directory creation..."
    sleep 1
    gum style --foreground="184" --margin="1 1" --strikethrough "           "
    gum style --foreground="208" --padding="1 0" "Cleaning temporary directory *$TMP_DIR*"
    rm -rf $TMP_DIR/* 2>&1 >> $MAIN_LOG
    EXIT=$?
    if [ $EXIT != 0 ]; then
	ERR_MSG="Failed cleaning temporary directory." | tee -a $MAIN_LOG
	prt_err
    fi
    gum style --foreground="154" --padding="1 0" "Cleaning complete"
    sleep 1
    gum style --foreground="184" --margin="1 1" --strikethrough "           "
else
    gum style --foreground="208" --padding="1 0" "Creating temporary directory *$TMP_DIR*"
    mkdir -p $TMP_DIR 2>&1 >> $MAIN_LOG
    EXIT=$?
    if [ $EXIT != 0 ]; then
	ERR_MSG="Failed to create directory *$TMP_DIR*" | tee -a $MAIN_LOG
	prt_err
    fi 
    gum style --foreground="154" --padding="1 0" "Temporary directory *$TMP_DIR* created"
    gum style --foreground="184" --margin="1 1" --strikethrough "           "
fi
read
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
read
#sudo tmux attach -t root:0.0
tmux kill-server
sudo tmux kill-server