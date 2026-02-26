#!/bin/env bash

# Make command failure stop execution
set -e

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo."
   exit 1
fi


printf "Removing individual snap packages...\n"
snap remove --purge firefox
snap remove --purge gtk-common-themes
snap remove --purge snap-store
snap remove --purge firmware-updater
snap remove --purge prompting-client
snap remove --purge desktop-security-center
snap remove --purge snapd-desktop-integration
snap remove --purge gnome-42-2204
snap remove --purge core22
snap remove --purge bare
snap remove --purge snapd

printf "Enabling expiremental option to hide the snap folder.\n"
snap set system experimental.hidden-snap-folder=true

printf "Installing individual snap packages...\n"
snap install snapd
snap install bare
snap install core22
snap install gnome-42-2204
snap install snapd-desktop-integration
snap install desktop-security-center
snap install prompting-client
snap install gtk-common-themes

printf "All done!\n"

