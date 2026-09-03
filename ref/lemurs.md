# Lemurs Login Manger

## Information

1. Lemurs is a "TUI" that acts as a display/login manager for window managers. It has a very simple interface and is very light on depdancies.
	- Github: https://github.com/coastalwhite/lemurs
	- Example screenshot: https://github.com/coastalwhite/lemurs/raw/main/assets/cover.png
	- Install script: (uses cargo): https://raw.githubusercontent.com/coastalwhite/lemurs/refs/heads/main/install.sh
2. It is not avaiable as a Debian package or on any Debian derivitives. However I have used it in the past and I was impressed with it.
3. Works much better than greetd and empTTY.
4. Configuration files location: /etc/lemurs
5. Scripts for launching windows managers: /etc/lemurs/wayland (Wayland) + /etc/lemurs/wms (X11)
6. Requires configuration. 
	- Files are variables.toml and config.toml. 
	- One provides the variables to the other. 
	- Seems a litte over the top for a minimal configuration but better than I can do!
## Dependancies

- build-essential
- librust-pam-sys-dev
- libpam0g-dev

