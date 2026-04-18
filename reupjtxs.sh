#!/bin/bash
# File: reupjtxs.sh

: <<'info'
    description
        deletes all of the files related to the current installation of
        jatexstudio and reinstalls it

        i made this to be able to quickly test out changes i made to
        the source code

        if you aren't me just use the BUILD.sh that's still in the
        repository
info

# clean up the old installation to make way for the new one
rm -r "${JATEXSTUDIO_PATH}/local/"
rm -r "${JATEXSTUDIO_PATH}/build/"

mkdir "${JATEXSTUDIO_PATH}/local/"
mkdir "${JATEXSTUDIO_PATH}/local/bin/"
mkdir "${JATEXSTUDIO_PATH}/local/share/"
mkdir "${JATEXSTUDIO_PATH}/build/"

# append a modified version of BUILD.sh for convenience
echo "TeXstudio compilation :"
echo "----------------------------------------"

# Autodetect operating system
if (uname -s | grep Darwin); then SYSTEM=2; else SYSTEM=1; fi

#ask
echo "Enter SYSTEM (1: UNIX ; 2: MACOSX)"
SYSTEM=1
echo "${SYSTEM}"

#pass parameters to cmake
TXSCOMPILEOPTIONS=$*

echo "Enter PREFIX (/usr , /usr/local or /opt)"
PREFIX="${JATEXSTUDIO_PATH}/local"
echo "${PREFIX}"

echo "Do you want to use the video player in pdf files (requires the qtmulitmedia library)?"
OPTION_MEDIAPLAYER="no"
echo "${OPTION_MEDIAPLAYER}"

echo "Do you want to build a debug or release version?"
OPTION_DEBUG_BUILD="yes"
echo "${OPTION_DEBUG_BUILD}"

echo "Do you want to include tests in the debug build?"
OPTION_TESTS="yes"
echo "${OPTION_TESTS}"

echo "Do you want to enable the debug logger?"
OPTION_DEBUG_LOGGER="no"
echo "${OPTION_DEBUG_LOGGER}"

echo "Do you want to install TexStudio after building it?"
DO_INSTALL="yes"
echo "${DO_INSTALL}"

TXSCOMPILEOPTIONS="${TXSCOMPILEOPTIONS} -DCMAKE_INSTALL_PREFIX=${PREFIX}"

#compile
if [[ "$OPTION_MEDIAPLAYER" == "yes" ]];  then TXSCOMPILEOPTIONS="${TXSCOMPILEOPTIONS} -DTEXSTUDIO_ENABLE_MEDIAPLAYER=on"; fi
if [[ "$OPTION_TESTS" == "no" ]];         then TXSCOMPILEOPTIONS="${TXSCOMPILEOPTIONS} -DTEXSTUDIO_ENABLE_TESTS=on"; fi
if [[ "$OPTION_DEBUG_BUILD" == "yes" ]];  then TXSCOMPILEOPTIONS="${TXSCOMPILEOPTIONS} -DCMAKE_BUILD_TYPE=Debug"; fi
if [[ "$OPTION_DEBUG_LOGGER" == "yes" ]]; then TXSCOMPILEOPTIONS="${TXSCOMPILEOPTIONS} -DTEXSTUDIO_ENABLE_DEBUG_LOGGER=on"; fi

# set the -spec option, if necessary. Ex : qmake -spec linux-g++ PREFIX=${PREFIX} texstudio.pro
echo "Starting compilation"
# for some reason putting quotes around the variables in the cmake statement below fucks up the
# install prefix path so when the installer comes around it starts screaming how it doesn't have
# permission to access my /usr/share/ directory. so that's why there's a shellcheck disable below
# shellcheck disable=SC2086
cmake -Wno-dev PREFIX=$PREFIX $TXSCOMPILEOPTIONS . -B ./build
cmake --build ./build --parallel
echo "Compilation done"

if [[ "$DO_INSTALL" == "yes" ]]; then
    cmake --build ./build -t install
    echo "Installation done"
    echo "Icons and desktop file can be found in the ${PREFIX}/share/texstudio directory"
fi

exit 0
