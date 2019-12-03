#!/usr/bin/env bash

# check if there was a command passed
init.sh

if [ "$1" ]; then
    # execute it
    PASSED_COMMAND="$@"
    eval "$PASSED_COMMAND"
fi
