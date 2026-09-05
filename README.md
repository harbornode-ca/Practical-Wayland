# Practical-Wayland

## What is this?

This project is a set of Bash scripts that sets up some Wayland environments that are not readily available on Debian. I started this project to easily setup some Wayland environments that I run on my and my families systems. This allows these environments to be deployed and themed consistently, with custom scripts for keeping everything up to date.

This project also includes a set of scripts that automate the installation of a base system, which includes a set of tools and utilities that I use on a daily basis. It also includes scripts for installing gaming software, AI software, and development software.

## The Philosophy

Debian provides a stable Linux OS. I frequently hear how far behind Debian is compared to other distros. I want to prove that you can have a stable Linux OS that is also modern and up to date.  Wayland has been around for a while and is clearly the future of the Linux desktop. However there is so many projects, so many DE's, shells, window managers, and so many ways to implement Wayland. 

While Debian provides a stable linux base and a massive repository of software, it does not always provide the most up to date versions of software. This can be a good thing for stability, but it can be a bad thing for features. It can also be a bad thing for Wayland compositors, as they are constantly being updated with new features and bug fixes. 

These Desktop environments are not available in the main Debian repositories and those that are available in the repositories are not the latest versions. Plus many of the features that are available in these environments are not working or are not implemented in the Debian versions. So instead of creating another distribution of linux to run these environments on, I am creating a set of scripts to install and setup these environments on Debian. This allows you to have a stable base with the latest versions of the software you want to use.

## How does it work?

The initial.sh script is run as root on a base install of Debian. So Debian with just the basic system tools. Then a guided setup continues from there setting up all the files and software automatically.

## What Wayland environments are you talking about?

**Currently developing support for the following environments:**
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
  [] Add CLI for install scripts.
  [] WinApps installer implementation of dockur for Windows Apps on Linux.
  [] Base system apps installation script
  [] Gaming Package Software installer script
  [] AI Package Software installer script
  [] Dev Package Software installer script
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

## Installing

*This will be populated once I decide on the best way to present the install commands.*

## Tools and Utilities

*Placeholder for information on custom tools and utilities included in the installation packages.*

## Themes

*Theme information will be populated once the custom themes are created and implemented.*

## Possible Future Additions

  - *Add installation for River based Wayland environments, like Canoe.*
  - *Add Sway and Hyperland options.*
  - *Add nwg-shell implementation.*

## License

MIT License

Copyright (c) 2026 Kevrevrun

## Contributing

I do not have any guidelines for contributing. If you want to contribute, feel free to fork the project and make changes. If you want to merge changes back, open a pull request and I will review it. I appreciate any and all contributions, big or small. Thanks!

## Acknowledgments

I would like to thank the whole open source community for all their hard work and dedication to creating these amazing projects. Without them, this project would not be possible.

Check out and support the projects I am including in the software packages in the packaged-software.md in the refs folder (https://github.com/harbornode-ca/Practical-Wayland/blob/main/ref/packaged-software.md)

This project relies on the work of the Debian project. A massive thanks to the Debian team for their hard work and dedication to creating this amazing operating system. It has been my main Linux OS since 2000. 

Special thanks to the developers of the Wayland desktop project I am featuring and using in this project. Without their hard work, this project would not be possible.

1. Niri - Awesome scrolling experience.
2. Ashell - Awesome panel.
3. Cosmic DE - Thank you to the PopOS team for this work in progress.
4. Lemurs - Display/Login Manager. Used in Niri and lxqt-niri implementation.
5. Fuzzel - Application Menu. Used in Niri and lxqt-niri implementation.
6. Wako - Notification daemon for Niri. Used in Niri and lxqt-niri implementation.
7. Xwayland-Satellite - X11 Support for Niri. Used in Niri and lxqt-niri implementation.
8. The whole Noctalia Project! V5 is looking really good. (Umbriel, Noctalia, Greeter)
9. lxqt - Awesome Qt Desktop Environment. The basic for the Niri Qt Implementation.
10. 