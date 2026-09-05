## APT Repository Files

Pre-configured repository files that can be copied from to change active and inactive repositories.

When running Debian Testing it's very likely you'll run into a package that has a broken dependency. This is where this folder comes in. You can quickly enable and disable repositories to install the package you need. Whether that is pulling it from Stable/Backport or Sid. These files will be used by the updating script to try and resolve the broken dependency.

This is not implemented yet. However the installer gives the user the option to upgrade to Debian Forky. This provides files to quickly build .sources files when updating to Forky.
