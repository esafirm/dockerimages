#!/usr/bin/env bash

GITHUB_BASE="https://github.com/esafirm/dockerimages/blob/master/alpine-android/bin"

DBX_LINUX_LINK="$GITHUB_BASE/linux/dbxcli?raw=true"
GDRIVE_LINUX_LINK="$GITHUB_BASE/linux/gdrive?raw=true"

DBX_OSX_LINK="$GITHUB_BASE/osx/dbxcli?raw=true"
GDRIVE_OSX_LINK="$GITHUB_BASE/osx/gdrive?raw=true"

DBX_DEST=usr/local/bin/dbxcli
GDRIVE_DEST=usr/local/bin/gdrive

## In case it doesn't exist
mkdir -p /usr/local/bin

installDbx() {
    LINK=$1
    if [[ $NEED_DBX ]]; then
        curl -sL $LINK > $DBX_DEST
        chmod +x $DBX_DEST
    else
        echo "Machine already have dbxcli"
    fi
}

installGdrive() {
    LINK=$1
    if [[ $NEED_GDRIVE ]]; then
        curl -sL $LINK > $GDRIVE_DEST
        chmod +x $GDRIVE_DEST
    else
        echo "Machine already have gdrive"
    fi
}

OS=$(uname)

if [[ $(command -v dbxcli) ]]; then
    NEED_DBX=true
fi

if [[ $(command -v gdrive) ]]; then
    NEED_GDRIVE=true
fi

if [[ $OS == "Darwin" ]]; then
    installDbx $DBX_OSX_LINK
    installGdrive $GDRIVE_OSX_LINK
else
    installDbx $DBX_LINUX_LINK
    installGdrive $GDRIVE_LINUX_LINK
fi

## Setup firebase
curl -sL firebase.tools | bash

