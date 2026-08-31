#!/bin/bash
# File: open-dir-in-dolphin.sh

: <<'info'
    required packages
        dolphin
        kdotool

    description
        opens, orphans, and focuses on dolphin at the directory stored in the input argument
info

# open and orphan dolphin at the directory $1
((dolphin "${1}" &> /dev/null;) &)

# search for instances of windows with containing dolphin in it's title and save the first
windowsearch=$(kdotool search --name --class --limit 1 "dolphin")

# if there are no windows found, exit silently
[[ -z "${windowsearch}" ]] && exit 0

# focus on dolphin window
kdotool windowactivate "${windowsearch}"
