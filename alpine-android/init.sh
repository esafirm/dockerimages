#!/usr/bin/env bash

if [[ -z $DBX_AUTH_TOKEN ]]; then 
    mkdir -p $HOME/.config/dbxcli
    echo "{\"\":{\"personal\":\"$DBX_AUTH_TOKEN\"}}" > $HOME/.config/dbxcli/auth.json
else
    echo "Do DBX auth token provided!"
fi

