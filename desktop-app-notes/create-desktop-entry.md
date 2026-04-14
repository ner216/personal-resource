# Desktop Entries (GNOME)

A file that adds an 'entry' to the desktop application lists.

- Create a file in `~/.local/share/applications/` that ends with `.desktop`.

Professional applications will store their desktop file in `/usr/share/applications/`.

You can validate the syntax of a desktop file with:
- `desktop-file-validate /usr/share/applications/<app>.desktop`

You can also test if the desktop file properly launches that app with:
- `gtk-launch <app-name>`

You can update the desktop shortcut database with:
- `sudo update-desktop-database /usr/share/applications`



