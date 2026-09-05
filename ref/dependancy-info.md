# Niri Based Desktop Environment

---

## niri
### Window Manager

#### Resrouces
Git: https://github.com/niri-wm/niri
Docs: https://niri-wm.github.io/niri/Getting-Started.html


##### Notes
1. Build command:
	- cargo build --release
2. Install file locations
	- File --> Destination
	1. target/release/niri --> /usr/local/bin/
	2. resources/niri-session --> /usr/local/bin/
	3. resources/niri.desktop --> /usr/local/share/wayland-sessions/
	4. resources/niri-portals.conf -->	/usr/local/share/xdg-desktop-portal/
	5. resources/niri.service --> /etc/systemd/user/
	6. resources/niri-shutdown.target --> /etc/systemd/user/

#### Dependancies
- gcc 
- clang 
- libudev-dev
- librust-libudev-dev
- libgbm-dev 
- libxkbcommon-dev
- libegl1-mesa-dev 
- libwayland-dev 
- libinput-dev 
- libdbus-1-dev 
- libsystemd-dev
- librust-libsystemd-dev
- libseat-dev 
- libpipewire-0.3-dev 
- libpango1.0-dev 
- libdisplay-info-dev
- librust-libdisplay-info-dev
- xwayland


## ashell
### Status Bar/Shell

#### Resources
Git: https://github.com/MalpenZibo/ashell
Docs: https://malpenzibo.github.io/ashell/docs/intro

##### Notes:
1. Sample config file: https://malpenzibo.github.io/ashell/docs/configuration/full_config
2. Build command:
	- cargo build --release
	- To install it system-wide: sudo cp target/release/ashell /usr/local/bin/ashell

#### Dependancies
- wayland-protocols
- clang
- libxkbcommon-dev
- libwayland-dev
- librust-dbus-udisks2-dev
- librust-dbus-dev
- libpipewire-0.3-dev
- librust-libpulse-binding-dev
- librust-libpulse-mainloop-glib-sys-dev
- librust-libpulse-glib-binding-dev
- libpulse-dev

#### Todo
1. Get source file link
2. Customize Configuration

## Lemurs
### Display/Login Manager

#### Resources
Git: https://github.com/coastalwhite/lemurs
Docs: No seperate docs website, just git README.md

##### Notes
1. Sample config file: https://github.com/coastalwhite/lemurs/blob/main/extra/config.toml

#### Dependancies

- build-essential
- librust-pam-sys-dev
- libpam0g-dev

## xwayland-satellite
### X11 Support

- xcb
- libxcb-util-dev
- librust-xcb-dev
- libxcb1-dev

---

# Noctalia Dekstop Environment

### Resources
Main page: https://noctalia.dev/

## Umbriel
### Window Manager

#### Resources
Git: https://github.com/noctalia-dev/umbriel
Docs: https://docs.noctalia.dev/umbriel/

## Noctalia
### Desktop Shell

#### Resources
Git: https://github.com/noctalia-dev/noctalia
Docs: https://docs.noctalia.dev/noctalia/

## Greeter
### Display/Login Manger

#### Resources
Git: https://github.com/noctalia-dev/noctalia-greeter
Docs: https://docs.noctalia.dev/greeter/

---

# Cosmic Desktop Environment

#### Resources
Main Git: https://docs.noctalia.dev/greeter/
Arch Wiki Docs: https://wiki.archlinux.org/title/COSMIC

#### Dependancies

- build-essential
- dbus
- git
- libclang-dev
- libdbus-1-dev
- libdisplay-info-dev
- libexpat1-dev
- libflatpak-dev
- libfontconfig-dev
- libfreetype-dev
- libgbm-dev
- libglvnd-dev
- libgstreamer-plugins-base1.0-dev
- libgstreamer1.0-dev
- libinput-dev
- libpam0g-dev
- libpipewire-0.3-dev
- libpixman-1-dev
- libpulse-dev
- libseat-dev
- libssl-dev
- libsystemd-dev
- librust-libsystemd-dev
- libwayland-dev
- libxkbcommon-dev
- lld
- mold
- udev
- librust-libudev-dev
- librust-libudev-sys-dev
- librust-udev-dev
- librust-udevrs-dev
- libudev-dev

Special:
- rustup (system-wide)
- cargo (system-wide)
- just (system-wide)

#### Notes
1. Pulling from git: git clone --recurse-submodules https://github.com/pop-os/cosmic-epoch
2. For packaging reference, look at the debian folders in the projects repositories. 
   These and the justfile inside this repository may be used as references on how to package COSMIC DE, 
   though no backwards-compatibility guarantees are provided at this stage.

---

# System Software

## Base Install

- **WinApps** - Git: https://github.com/winapps-org/winapps (Website: https://winapps.org/)
	- *Run windows applications inside your linux environment*
- **Rat Commander** - Git: https://github.com/dividebysandwich/rat-commander (Website: https://rat-commander.com//)
	- *A modern version of the still relevant and classic Midnight Commander.*
- **Tmux** - Git: https://github.com/tmux/tmux (with plugins like Powerline: https://github.com/erikw/tmux-powerline)
	- *A terminal multiplexer that allows you to create and manage multiple terminal sessions within a single terminal window.*
	- * Most populat terminal multiplexer. Compatible with modern terminal emulators like alcritty,kitty, foot.*
- **Rustic** - Git: https://github.com/rustic-rs/rustic (Website: https://rustic.cli.rs/)
	- *Back up software based on restic written in rust*
- **Zerobyte** - Git: https://github.com/nicotsx/zerobyte (Website: https://zerobyte.app/)
	- *Zerobyte is a backup manageer for Rustic*
- **Portal** - Git: https://github.com/SpatiumPortae/portal (Website: https://portal.spatiumportae.com)
	- *Portal is a simple, beautiful, and transparent file-sharing application that allows you to easily share files between your devices.*
- **Hishtory** - Git: https://github.com/ddworken/hishtory
	- *Hishtory is a shell command history search tool*
- **eget** - Git: https://github.com/zyedidia/eget
	- *eget is a tool for downloading binaries from GitHub releases.*
- **Pop** - Git: https://github.com/charmbracelet/pop
	- *Pop is a mail app for your terminal*
	- *Supports most modern main services including Gmail, Outlook, Office365, etc
- **Hazelnut** - Git: https://github.com/ricardodantas/hazelnut
	- *File organizer for your terminal*
- **hours** - Git: https://github.com/aaronriekenberg/hours
	- *hours is a time tracker for your terminal*
	- *easy to use command line timer to help you keep track of time spent on tasks*
- **Voxtype** - Git: https://github.com/peteonrails/voxtype (Website: https://voxtype.io)
- **Markpad** - Git: https://github.com/sftwrdotdev/Markpad
	- *A fast, feature-rich Markdown editor for Linux*
- Pake - Git: https://github.com/tw93/Pake (Website: https://faberon.io/projects/pake)
	- *Turn any website into a desktop app*
	- *Uses Rust + Tauri instead of Electron*
- **Fresh** - Git: https://github.com/sinelaw/fresh (Website: https://getfresh.dev)
	- *TUI based IDE & Text Editor*
- **Walk** - Git: https://github.com/antonmedv/walk
	- *They call it a "terminal navigator"*
	- *Visual tui replacement for cd and ls*
- **Bluetui** - Git: https://github.com/pythops/bluetui
	- *Bluetooth manager in the terminal*
- **Syncthing** - Git: https://github.com/syncthing/syncthing (Website: https://syncthing.net/)
	- *It is a continuous file synchronization program. It protects your privacy by preventing the need to store your personal data on a third-party cloud.*

## Dev Package

*Placeholder for software list for software development*

## AI Package

*Placeholder for software list for AI applications*