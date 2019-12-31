#!/usr/bin/env bash
set -e

echo "Hello ENTRYPOINT" >> hello

## Running passed command
if [[ "$1" ]]; then
	eval "$@"
fi