import os
import subprocess

print("WARNING: This script is designed to be used on fresh installations only!")

# ANSI colors
YELLOW = "\033[33m"
BLUE = "\033[34m"
RED = "\033[31m"
GREEN = "\033[32m"
RESET = "\033[0m" #Reset default to color

# A dictionary containing all known snaps
SNAP_LIST = {
    0:"firefox",
    1:"gtk-common-themes",    # Integrate popular GTK themes to installed snap packages
    2:"snap-store",
    3:"firmware-updater",
    4:"prompting-client",     # Manages permissions for snap applications such as requesting access
    5:"desktop-security-center",
    6:"snapd-desktop-integration",    # Bridge snaps to desktop environment, mainly used for theming
    7:"gnome-42-2204",        # Provide Gnome 42 libraries. Used for snap-store and firefox.
    8:"core22",               # Runtime environment which provides libraries (based on Ubuntu 22.04 LTS)
    9:"bare",                 # A base snap used for minimal snaps (ex. gtk-common-themes)
    10:"snapd"
}

# Snap orders for Ubuntu 25.10
class version(object):
    def __init__(self):
        pass
    
    def 
    UBUNTU_25_10_SNAP_REMOVAL_ORDER = [0,1,2,3,4,5,6,7,8,9,10]
    UBUNTU_25_10_SNAP_INSTALL_FULL = [0,1,2,3,4,5,6,7,8,9,10]
    UBUNTU_25_10_SNAP_INSTALL_MINIMAL = [1,4,5,6,7,8,9,10]

# System Configuration functions ------------------------------------------------------------------

# Remove snap packages and/or snapd from the system
#   'full': When true, will remove snapd along with snap packages 
def remove_snap(removal_order: list, full: bool) -> None:
    try:
        for snap_id in removal_order:
            snap_name = SNAP_LIST[snap_id]
            rm_snap = f"snap remove --purge {snap_name}"
            print(f"{RED}Removing snap {snap_name}...{RESET}")
            subprocess.run(rm_snap, shell=True, check=True)
            print(f"{GREEN}Successfully removed {snap_name}.{RESET}")
    except CalledProcessError as e:
        print(f"[ERROR] Comamnd failed to run: {e}")
        exit(1)
    
    if full == True:
        rm_snapd = "apt remove --purge -y snapd && apt-mark hold snapd && apt autoremove -y"
        rm_snap_folder = "rm -rf ~/snap"
        try:
            print(f"{RED}Removing snapd...{RESET}")
            subprocess.run(rm_snapd, shell=True, check=True)
            print(f"{GREEN}Successfully removed snapd.{RESET}")
            print(f"{RED}Removing '/home/{USER}/snap'{RESET}")
            subprocess.run(rm_snap_folder, shell=True, check=True)
            print(f"{GREEN}Successfully removed '/home/{USER}/snap'{RESET}")
        except CalledProcessError as e:
        print(f"[ERROR] Comamnd failed to run: {e}")
        exit(1)

def install_snap(install_order: list, full: bool) -> None:

    

