#!/bin/bash
CFG_DIR=/opt/kevrevrun
IST_DIR=$PWD
echo $IST_DIR > $CFG_DIR/install.dir
banner () {
echo
echo "  ---------------------------------------------------------------------------"
echo "  |                            *** KEVREVRUN ***                            |"
echo "  |                               * Presents *                              |"
echo "  |                  In association with Crappy-Bash-Scripts                |"
echo "  |                   Practical Debian Wayland Environments                 |"
echo "  ---------------------------------------------------------------------------"
echo
echo
sleep 1
# End of banner
}
# Print error message to screen when command fails.
prt_err () {
clear
banner
echo "  ------------"
echo "  |  ERROR!  |"
echo "  ------------"
echo
echo "  $ERR_MSG"
echo
echo "  Exit Code: $EXIT -  Check failed.log for details"
echo  $RN > ./failed.log
sleep 1
echo
echo "  Output saved to failed.log"
echo
echo "  This script will now exit"
exit 1
}
invalid () {
clear
banner
echo "  INVAILD RESPONSE ENTERED!"
echo "  Please enter a vailid response"
read -p "  Press Enter to retry"
}
add_sudo () {
echo
echo "  -----------------------"
echo "  |  Setting Sudo User  |"
echo "  -----------------------"
sleep 1
echo
echo "  Gathering user information"
sleep 1
echo
echo "  Enter the username of user to be given sudo permission below"
read -p "  > " SUDO_USER
echo
echo "  Checking if $SUDO_USER is a valid user"
sleep 1
SUDO_CHK=$(cat /etc/passwd | grep -c $SUDO_USER)
sleep 1
if [ "$SUDO_CHK" = "1" ]; then
	echo
	echo "  $SUDO_USER is a valid user!"
	sleep 1
	chk_sudo
else
	clear
	banner
	echo
	echo "  Please verify that the user entered is correct."
	add_sudo
fi
}
chk_sudo () {
echo
echo "  ------------------------"
echo "  |  Creating Sudo User  |"
echo "  ------------------------"
sleep 1
echo
echo "  Do you want to give $SUDO_USER root priviledges [y/n]"
read -p "  > " CONFIRM
if [ "$CONFIRM" = "y" ]; then
	echo
	echo "  Root priviledges will be given to $SUDO_USER..."
	sleep 1
elif [ "$CONFIRM" = "n" ]; then
	clear
	banner
	sleep 1
	echo
	echo "  Please enter the username that you want to give root access to on the next screen"
	echo
	read -p "  Press Enter to re-enter username"
	add_sudo
else
	invalid
        chk_sudo
fi
echo
echo "  Applying sudo group to $SUDO_USER"
sleep 1
RN=$(usermod -aG sudo $SUDO_USER 2>&1)
EXIT=$?
if [ $EXIT != 0 ]; then
	ERR_MSG="Error adding $SUDO_USER to the sudo group"
	prt_err
else
	echo
	echo "  The user $SUDO_USER now has root access"
	sleep 1
fi
}
clear
banner
echo "  Hold on a sec...They are telling me I need to check ID..."
sleep 1
echo
echo "  Checking root access..."
sleep 1
if [ "$EUID" != 0 ]; then
	echo
	echo "  *****************"
	echo "  *** IMPORTANT ***"
	echo "  *****************"
	echo
	echo "  --------------------------------------------------------"
	echo "  | Error: Root access not detected!                     |"
	echo "  | Login as root and re-run this script.                |"
	echo "  | *Note: Debian does not setup a sudo user by default* |"
	echo "  --------------------------------------------------------"
	echo
	echo "  *****************"
	echo "  *** IMPORTANT ***"
	echo "  *****************"
	echo
	echo "  This script will now exit"
	echo
	sleep 1
	read -p "  Press Enter to exit"
        clear
	exit 1
else
	echo
	echo "  Root access has been granted!!!"
	echo
	read -p "  Press Enter to continue"
fi
clear
banner
echo
echo "  ---------------------------------------- "
echo "  |  Installing Updates & Need Packages  | "
echo "  ---------------------------------------- "
sleep 1
echo
echo "  Refreshing the package cache... "
RN=$(apt update)
EXIT=$?
if [ $EXIT != 0 ]; then
	ERR_MSG="Failed to update package cache"
	prt_err
else
	echo
	echo "  The package cache has updated sucessfully"
fi
PKG_UPG=$(apt update | grep -c "packages can be upgraded")
if [ $PKG_UPG = 1 ]; then
	echo
	echo "  Updates are available."
	echo
	echo "  Installing updates"
	RN=$(apt upgrade -y 2>&1)
	EXIT=$?
	if [ $EXIT != 0 ]; then
		ERR_MSG="Failed to install updates"
		prt_msg
	else
		echo
		echo "  Update prcoess has completed sucessfully"
		sleep 1
	fi
else
	echo
	echo "  System is already up to date"
	sleep 1
	echo
	echo "  No updates to install"
	sleep 1
fi
echo
echo "  Running apt to install packages..."
RN=$(apt install sudo fonts-nerd-symbols fonts-font-awesome unzip git tmux gpg wget curl build-essential whiptail firmware-linux firmware-linux-nonfree -y 2>&1)
EXIT=$?
if [ $EXIT != 0 ]; then
	ERR_MSG="Failed to install packages"
	prt_err
else
	echo
	echo "  Package installation has completed sucessfully"
	sleep 1

fi
add_sudo
echo
echo "  --------------------------------------"
echo "  |  Setting Up Directories and Files  |"
echo "  --------------------------------------"
echo
echo "  Configuring setup files..."
sleep 1
if [ -d $CFG_DIR ]; then
	echo
	echo "  Configuration directory already exists"
	sleep 1
	echo
	echo "  Skipping folder creation"
	sleep 1
else
	RN=$(mkdir $CFG_DIR 2>&1)
	if [ -f $CFG_DIR ]; then
		echo
		echo "  The config directory has been created"
		sleep 1
	else
		ERR_MSG="  Failed to create directory."
		prt_err
	fi
fi
for f in repos status setup scripts configs; do
	if [ -d $CFG_DIR/$f ]; then
		echo
		echo "  The directory $f already exists"
		echo
		echo "  Skipping directory creation"
		sleep 1
	else
		echo
		echo "  Creating directory $f"
		sleep 1
		mkdir $CFG_DIR/$f
		if [ -d $CFG_DIR/$f ]; then
			echo
			echo "  The directory $f was sucessfully created"
			sleep 1
		else
			ERR_MSG= "  Failed to create directory $f"
			prt_err
		fi
	fi
done
echo
echo "  Setting up user file permissions"
sleep 1
echo
echo "  Getting user details"
sleep 1
USR_NM=$SUDO_USER
USR_ID=$(cat /etc/passwd | grep $USR_NM | cut -d ":" -f 3)
sleep 1
echo
echo "  Setting file permissions"
sleep 1
RN=$(chown -R $USR_NM:$USR_NM $CFG_DIR)
OWN_USR=$(ls -ld $CFG_DIR | cut -d " " -f 3)
OWN_GRP=$(ls -ld $CFG_DIR | cut -d " " -f 4)
if [ $OWN_USR = $USR_NM ]; then
	if [ $OWN_GRP = $USR_NM ]; then
		echo
		echo "  File permission have been properly set"
		sleep 1
	else
		ERR_MSG="  Failed to set file permissions"
		prt_err
	fi
fi
echo
echo "  Downloading script to continue setup..."
sleep 1
RN=$(wget -O "/home/$SUDO_USER/setup.sh" "https://raw.githubusercontent.com/harbornode-ca/kevrevrun-deb/refs/heads/main/setup.sh" 2>&1)
EXIT=$?
if [ "$EXIT" != "0" ]; then
	ERR_MSG="Script failed to download"
else
	echo
	echo "  Script downloaded sucessfully"
	sleep 1
fi
echo
echo "  Setting file permissions..."
sleep 1
RN=$(chown $SUDO_USER:$SUDO_USER /home/$SUDO_USER/setup.sh && chmod +x /home/$SUDO_USER/setup.sh)
EXIT=$?
if [ $EXIT != 0 ]; then
	ERR_MSG="Failed to set file/folder permissions"
	prt_err
else
	echo
	echo "  Sucessfully applied file permisssions"
fi
echo
echo "  Saving some information for the next steps of the installation..."
sleep 1
id -u $SUDO_USER > $CFG_DIR/id.usr
echo $SUDO_USER > $CFG_DIR/name.usr
if [ -f  /etc/kevrevrun/id.usr ]; then
	if [ -f  /etc/kevrevrun/name.usr ]; then
		echo
		echo "  Finished saving information"
		sleep 1
	else
		ERR_MSG="Failed to create files"
		prt_err
	fi
fi
echo
echo "  Finished setting up files and directories"
sleep 1
echo
echo "  ---------------------------------------"
echo "  |  Installing Charmbracelet Gum Tool  |"
echo "  ---------------------------------------"
echo
# Downloading the Gum .deb installer
echo "  Downloading Gum... "
sleep 1
GUM_URL=" https://github.com/charmbracelet/gum/releases/download/v0.17.0/gum_0.17.0_amd64.deb"
GUM_DEB="gum_0.17.0_amd64.deb"
RN=$(wget -o/tmp/gum_dl.log -O /tmp/$GUM_DEB $GUM_URL)
EXIT=$?
if [ ! -f /tmp/$GUM_DEB ]; then
        ERR_MSG="Download Failed!"
        prt_err
else
	echo
        echo "  Download was sucessful!"
        sleep 1
fi
# Installing Gum .deb file using apt
echo
echo "  Installing Gum..."
RM=$(apt install /tmp/$GUM_DEB -y --allow-downgrades 2>&1)
EXIT=$?
if [ $EXIT != 0 ]; then
        ERR_MSG="  Gum installed failed"
        prt_err
else
        echo
        echo "  The Gum package has been sucessfully installed"
fi
echo
echo "  Setup Complete!"
echo
read -p "  Press Enter to continue"
clear
banner
echo
echo " ---------------------"
echo " |  Setup Completed  |"
echo " ---------------------"
sleep 1
echo
echo
echo
echo "  *** IMPORTANT ***"
echo
echo
echo "  [Instructions]"
echo "  - The setup.sh files has been added to the home directory of SUDO_USER"
echo "  - A reboot is required to continue setup"
echo "  - Log in as $SUDO_USER when system restarts"
echo "  - Run sudo setup.sh from $SUDO_USER home directory"
echo
echo
sleep 1
read -p "  Press Enter to reboot the system"
echo
echo "  The system will now reboot..."
echo
sleep 2
reboot
clear
exit 0