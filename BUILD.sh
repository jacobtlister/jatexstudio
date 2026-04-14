#!/bin/sh
echo "TeXstudio compilation :"
echo "----------------------------------------"

# Autodetect operating system
if (uname -s | grep Darwin); then SYSTEM=2; else SYSTEM=1; fi

#ask
echo "Enter SYSTEM (1: UNIX ; 2: MACOSX)"
SYSTEM=1
echo $SYSTEM

#pass parameters to cmake
TXSCOMPILEOPTIONS=$*

echo "Enter PREFIX (/usr , /usr/local or /opt)"
PREFIX="/media/meapa/Shared/repos/jatexstudio/local"
echo $PREFIX
TXSCOMPILEOPTIONS="$TXSCOMPILEOPTIONS -DCMAKE_INSTALL_PREFIX=$PREFIX"

echo "Do you want to use the video player in pdf files (requires the qtmulitmedia library)?"
OPTION_MEDIAPLAYER="no"
echo $OPTION_MEDIAPLAYER

echo "Do you want to build a debug or release version?"
OPTION_DEBUG_BUILD="yes"
echo "debug"

echo "Do you want to include tests in the debug build?"
OPTION_TESTS="yes"
echo $OPTION_TESTS

echo "Do you want to enable the debug logger?"
OPTION_DEBUG_LOGGER="no"
echo $OPTION_DEBUG_LOGGER

echo "Do you want to install TexStudio after building it?"
DO_INSTALL="yes"
echo $DO_INSTALL

#compile
if [ "$OPTION_MEDIAPLAYER" = yes ];  then TXSCOMPILEOPTIONS="$TXSCOMPILEOPTIONS -DTEXSTUDIO_ENABLE_MEDIAPLAYER=on"; fi
if [ "$OPTION_TESTS" = no ];         then TXSCOMPILEOPTIONS="$TXSCOMPILEOPTIONS -DTEXSTUDIO_ENABLE_TESTS=on"; fi
if [ "$OPTION_DEBUG_BUILD" = yes ];  then TXSCOMPILEOPTIONS="$TXSCOMPILEOPTIONS -DCMAKE_BUILD_TYPE=Debug"; fi
if [ "$OPTION_DEBUG_LOGGER" = yes ]; then TXSCOMPILEOPTIONS="$TXSCOMPILEOPTIONS -DTEXSTUDIO_ENABLE_DEBUG_LOGGER=on"; fi

echo "Starting compilation"
if (test -d "./build") then echo "remove previous build folder";rm -rf ./build; fi
mkdir build
cmake -Wno-dev PREFIX=$PREFIX $TXSCOMPILEOPTIONS . -B ./build
cmake --build ./build --parallel
echo "Compilation done"

if [ "$DO_INSTALL" = yes ]; then
	cmake --build ./build -t install
	echo "Installation done"
	echo "Icons and desktop file can be found in the $PREFIX/share/texstudio directory"
fi

# set the -spec option, if necessary. Ex : qmake -spec linux-g++ PREFIX=$PREFIX texstudio.pro
exit 0
