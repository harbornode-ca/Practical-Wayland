# niri Window Manager


## Installation Resources
Vendored Dependancies: https://github.com/niri-wm/niri/releases/download/v26.04/niri-26.04-vendored-dependencies.tar.xz
Current version source: https://github.com/niri-wm/niri/archive/refs/tags/v26.04.tar.gz

## Installation Dependancies:

1. Notification Daemon:
	- Ashell has no documentation on the notification module however it is an included section in the example config file.
	- If not workable mako (https://github.com/emersion/mako) works well. Have used it before with niri.
2. xdg Portals
	- gtk - Basic required.
	- gnome - required for screencasting support
	- *Note* for flatpak support: dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'
	- *Note* Not using Nautilus so org.freedesktop.impl.portal.FileChooser=gtk; in niri-portals.conf for Nemo as the default.
3. Authentication Agent
	- Recommends plasma polkit. Why use qt when runing GTK?
	- Mate DE from Linux mint has a GTK polkit that works great. 
		- Debian packages: mate-polkit mate-polkit-bin (
		- *Note* Need both no dependancy for each other unless install Mate Desktop
4. Xwayland Satellite
	- Required for X11 support.
	- No Debian package need to build from source.
	- Dependancies for building source
		- xwayland
		- libwayland-dev
		- xcb (No stable library, pull from testing or oldstable)
		- libxcb-util-dev
		- clang
	- Current version source: https://github.com/Supreeeme/xwayland-satellite/archive/refs/tags/v0.8.2.tar.gz
	- Build instructions: cargo build --release -F systemd
	- Requires: graphical-session.target for systemd
5. Vulkan and EGL support are required: libegl-dev, libegl1-mesa-dev, libgegl-dev

### Building Dependancies:
- gcc 
- clang 
- librust-libudev-dev
- librust-libudev-sys-dev
- libudev-dev 
- libgbm-dev
- librust-xkb-dev
- librust-xkbcommon-dev
- librust-xkbcommon-dl-dev
- librust-xkbcommon-sys-dev
- libxkbcommon-dev 
- libegl1-mesa-dev 
- libwayland-dev 
- libinput-dev 
- libdbus-1-dev
- libdbusmenu-gtk-dev
- librust-libdbus-sys-dev
- libdbusmenu-gtk3-dev
- libdbusmenu-gtk4
- librust-libsystemd-dev
- libsystemd-dev
- libseat-dev
- librust-libseat-dev
- librust-libseat-sys-dev
- libpipewire-0.3-dev 
- libpango1.0-dev 
- libdisplay-info-dev
- librust-libdisplay-info-dev
- librust-libdisplay-info-sys-dev

### File Install Locations

| File | Destination |
|---|---|
| target/release/niri | /usr/bin/ |
| resources/niri-session | /usr/bin/ |
| resources/niri.desktop | /usr/share/wayland-sessions/ |
| resources/niri-portals.conf | /usr/share/xdg-desktop-portal/ |
| resources/niri.service (systemd) | /usr/lib/systemd/user/ |
| resources/niri-shutdown.target (systemd) | /usr/lib/systemd/user/ |


## Notes:

1. Electron apps do not use wayland by defalt >= 39 use: "--ozone-platform=wayland" to force wayland.
2. Zen Browser For some reason, DMABUF screencasts are disabled in the Zen Browser.
	- To fix it, open about:config and set widget.dmabuf.force-enabled to true.
3. Gamescope recommended (read REQUIRED) for fullscreen games. Installable as Debian Package: gamescope
	- Version is behind even in testing and sid. Can be build from source: https://github.com/ValveSoftware/gamescope
4. Steam needs -system-composer passed as launch argument to avoid web views issues.
5. Steam notification do not use system daemon. Custom config required in niri.
	- window-rule {
   	  match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
	  default-floating-position x=10 y=10 relative-to="bottom-right"
	  } 
6. Nvidia has issues with VRAM usage. Fix available: https://niri-wm.github.io/niri/Nvidia.html
	- May not be an issue for all cards and all driver versions.
7. Running X11 apps. Apps with issues can be used by creating a window and running a window manager inside it.
	- Documentation suggests: Labwc which is a wayland compositor with Xwayland. 
	- Another option is using an X11 compositor like i3 or other low dependancy/low resource window manager.
8. Proton may need to be forced for some games running under proton. 
	- Format the command using this variable: PROTON_ENABLE_WAYLAND=1 %command%
9. niri has a "Windowed Fullscreen" option that tells an app they are running in fullscreen event though they are in a window.
	- Use action: toggle-windowed-fullscreen


