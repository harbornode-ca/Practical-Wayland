# GPUs in Debain Forky

### Checking for GPU Type

User lspci and grep to check for GPU type. There can be multiple types of GPUs in a system.
Example most Intel and newer AMD CPUs have a GPU on the same die. Some systems have a discrete GPU as well. 
1. Check for each type of GPU using lspci | grep -i VGA
2. Identify the GPU type based on the output of lspci | grep -i VGA
3. Run an if loop to check for types in the system
4. Pass off to a install script for the detected GPU types

### Intel Integrated and Discrete Graphics

Intel is probably the easiest as long as the CPU isnt legacy and running an i915 or previous display adapter then the Mesa drivers are usually all that is needed.

1. Check if legacy adapter
2. Ask user and provide a resource to check if they are unsure.
3. Install Firmware for Intel GPU from Debian Forky
4. Install Mesa
5. Configure wayland with the correct driver
6. Wil need to reboot for non-legacy adapters

### AMD Integrated and Discrete Graphics

AMD is almost identical to Intel in respects to the Mesa drivers. Howver legacy drivers are handled with different firmware as well. 
AMD has open source drivers but has proprietary drivers available as well for some workstation cards.


1. Check if legacy adapter
2. Ask user and provide a resource to check if they are unsure.
3. Check if proprietary drivers are needed for the user's use case
4. Install Firmware for AMD GPU from Debian Forky
5. Install Mesa or Proprietary drivers depending on the users needs.
6. Configure wayland with the correct driver
7. Wil need to reboot after firmware install.

### NVIDIA Discrete Graphics

NVIDIA cards are the hardest to configure for period. There are three driver types to consider.

1. The Nouveau open source drivers. They are open source but not as well supported as the proprietary drivers.
The Nouveau drivers are included in Debian Forky. 
2. The NVIDIA proprietary drivers. They are included in Debian Forky in a non-free repository. They are not the open source drivers.
3. NVIDIA has an installer available for download from their website. This is the best driver to use and is the only way to get the absolute latest features and bug fixes.

When installing drivers there may have to be multiple restarts, and signing of the kernel module may be required. The signing key will need to be loaded into the Secure Boot options in the UEFI firmware.
The install process for NVIDIA is as follows:

1. Check if the user wants to use Nouveau or proprietary drivers
2. If Nouveau is chosen, then install Nouveau drivers from Debian Forky
3. If proprietary is chosen
    3.1 If the card is legacy
        Install the NVIDIA Drivers from the Non-Free repository in Debian Forky
        Reboot Required after install
    3.2 If the card is not legacy
        Download the latest script from the NVIDIA website.
        The script will handle the install and configuration of the NVIDIA drivers.
        Multiple reboots are likely required.
    3.3 Running the script
        The script will likely need to be run multiple times. Each run will likely require a reboot.
        Need to check the status with the user of the install after each run.
        In future development it would be better to check the logs for this information or some other method to automate the process. This will be added to the Roadmap.
    3.4 Install Steps
        - When the script first starts up it will ask the user what drivers they want to install Proprietary or MIT. Before running the script each time remind the user to pick Proprietary drivers.
        - The script will tell the user if they need to disable Nouveau drivers and will give the option to edit the system startup to block the drivers.
        - They should agree to have the script edit the startup files. This will stop the Nouveau drivers from loading on boot.
        - Need to reboot to get the changes to take effect.
        - Before the second run we should confirm if the user plans on playing games on the system or has some other need for i386 support. NVIDIA does not require this to run but it is required for things like steam and wine. Add i386 support to the repositories if required.
        - The system will need the libegl1, libglx0, libgbm1, libglvnd-dev libraries. Install it from the Debian Forky repository
        - After these are setup the script should only need to be run once more.
        - DKMS should be declined! Signing key location will need to be passed onto the install process so it can be installed and setup properly. This means we need to create the key as part of this process or ask the user to import it. 
    3.5 Known Issues
        - DKMS has not been working properly since Kernel 6.9? It required the NVIDIA drivers to be installed everytime the kernel is updated.
        - A basic script handling updating this will need to be created and a proper method for this should be added to the Roadmap for future development.
        - Will need mokutil for enrolling the key to the UEFI firmware.
        - Need to find flags for passing the signing key on to the installation so the same key can be used everytime.
        - Need to find what flags are available for the nvidia-driver install process to automate as much as possible. This should be added to the Roadmap as well.