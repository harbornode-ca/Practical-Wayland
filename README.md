# Practical-Wayland

## What is this?
This project is a set of Bash scripts that sets up some Wayland environments that are not readily available on Debian. I started this project to easily setup some Wayland environments that I run on my and my families systems. This allows these environments to be deployed and themed consistently, with custom scripts for keeping everything up to date.

## How does it work?
The initial.sh script is run as root on a base install of Debian. So Debian with just the basic system tools. Then a guided setup continues from there setting up all the files and software automatically.

## What Wayland environments are you talking about?
**Currently developing this script to support**
  1. Cosmic DE
  2. Noctalia V5
  3. Niri w/ Ashell Panel, Fuzzel Menu, Lemurs Login Manager.
  4. LXQt w/ Niri for Compositor.

## Current Development of Proposed Features:
[] Setup Scripts:
  [x] Initial Script Setup.
  [] Update system to Debian Testing.
  [] Install script for Niri DE.
  [] Install script for Cosmic DE.
  [] Install script for Noctalia V5.
  [] Install script for LXQt w/ Niri for Compositor.
  [] WinApps installer implementation of dockur for Windows Apps on Linux.
  [] Base system apps installation script
  [] Install script for Installing themes.
[] Tools and utilities:
  [] Setup a custom script for each environment for updating system packages.
  [] Setup a custom script for each environment for installing extra software.
  [] Package installer and uninstaller script. Featuring advanced dependency handling and orphaned package cleanup.
  [] Keybind visual editor.
[] Themes
  [] Installation of themes.
  [] Custom themes for each environment.
  [] Custom Themes:
    [] A retro 70's/80's with Commodore 64, Atari inspired colors. I am calling it "That 70's Theme"
    [] A nature inspired theme w/ Tom Thomson style colors. I am calling it "Muskoka Colors"
    [] A Doctor Who inspired theme. Obviously called "Doctor Who"
    [] A Modern Dark theme. Simply called "Dark"
    [] A Modern Light theme. Simply called "Light"
[] Possible Future Additions:
    [] Add installation for River based Wayland environments, like Canoe.
    [] Add Sway and Hyperland options
    [] Add nwg-shell implementation
