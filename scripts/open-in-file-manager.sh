#!/bin/bash
# File: open-in-file-manager.sh

: <<'info'
    required packages
        xdg-utils
        kdotool (only if using kde with wayland)

    description
        opens an orphaned file manager at the directory stored in the input argument
        also, if KDE is the desktop environment, focus on the file manager with kdotool
info

# open and orphan default file manager at the directory $1
( (xdg-open "${1}" &> /dev/null;) & )

# get the name of the default file manager used by xdg-open
filemanager="$(xdg-mime query default inode/directory)"
filemanager="${filemanager%.*}"
filemanager="${filemanager##*.}"

# if using kde with wayland, use kdotool to focus on the file manager
if [[ "${XDG_CURRENT_DESKTOP}" == "KDE" && "${XDG_SESSION_TYPE}" == "wayland" ]]; then
    # find the first instance of an open file manager window
    windowsearch=$(kdotool search --name --class --limit 1 "${filemanager}")

    # if there are no open file managers, exit silently
    [[ -z "${windowsearch}" ]] && exit 0

    # focus on file manager window
    kdotool windowactivate "${windowsearch}"
fi
