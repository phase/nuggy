#!/usr/bin/env bash

nuggy_help() {
    echo "Nuggy Help Script"
    echo "- nuggy build"
    echo "      Build Nuggy"
    echo "- nuggy run"
    echo "      Run Nuggy"
}

nuggy_build() {
    rm -rf *.exe
    SOURCES=$(find src/nuggy/ -iname "*.d")
    #TODO: Use other compilers
    dmd $SOURCES -of./nuggy.exe -v
}

nuggy_run() {
    ./nuggy -d
}

nuggy_reboot() {
    nuggy_build
    nuggy_run
}

if [ -z $1 ]; then
    nuggy_help
    exit
fi

if [ "$(type -t "nuggy_$1")" = "function" ]; then
    "nuggy_$@"
else
    >&2 echo "Unknown command: '$@'. Type '$0 help' for more information."
    exit 1
fi