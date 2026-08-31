#!/bin/bash
# File: openinbrowser.sh

: <<'info'
    required packages
        dolphin

    description
        opens dolphin (orphaned) at the directory of the file being currently edited
info

((dolphin "${1}" &> /dev/null;) &)

# search for instances of windows with containing dolphin in it's title and save the first
windowsearch=$(kdotool search --name --class --limit 1 "dolphin")

# if there are no windows found, exit silently
[[ -z "${windowsearch}" ]] && exit 0

kdotool windowactivate "${windowsearch}"
