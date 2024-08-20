#!/bin/bash

# Check if an single argument
if [ "$#" -eq 1 ]; then
    prefix_path="$1"
else
    prefix_path="$(pwd)"
fi

autoreconf --force --install
./configure --prefix="$prefix_path"

