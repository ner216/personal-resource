#!/bin/env bash

# Make command failure stop execution
set -e

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo."
   exit 1
fi


printf "Removing individual snap packages...\n"
snap remove firefox
snap remove gtk-common-themes
snap remove snap-store
snap remove firmware-updater
snap remove prompting-client
snap remove desktop-security-center
snap remove snapd-desktop-integration
snap remove gnome-42-2204
snap remove core22
snap remove bare
snap remove snapd

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

