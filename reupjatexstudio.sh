#!/bin/bash
# File: reupjatexstudio.sh

: <<'info'
    description
        deletes all of the files related to the current installation of
        jatexstudio and beings the reinstall process
info

# sources all functions in /scripts/funcs/
# commenting this so shellcheck doesn't freak out
# shellcheck source=/dev/null
for f in "${SCRIPTS_PATH}/funcs"/*.sh; do source "${f}"; done

# i know that im being lazy by using absolute paths fuck off
rm -rf /media/meapa/Shared/repos/jatexstudio/local/share/
mkdir  /media/meapa/Shared/repos/jatexstudio/local/share/
rm     /media/meapa/Shared/repos/jatexstudio/local/bin/texstudio

rm -rf /media/meapa/Shared/repos/jatexstudio/build/

/media/meapa/Shared/repos/jatexstudio/BUILD.sh