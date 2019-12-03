#!/usr/bin/env bash

mkdir -p $HOME/.config/dbxcli
echo "{\"\":{\"personal\":\"$DBX_AUTH_TOKEN\"}}" > $HOME/.config/dbxcli/auth.json
