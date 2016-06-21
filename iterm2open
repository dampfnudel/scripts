#!/bin/bash

# open textfiles with "mvim --remote-tab-silent {file} +{linenumber}". Open other files with "open"

FULLFILE="$1"
LINE="$2"

FILENAME=$(basename "$FULLFILE")
EXTENSION="${FILENAME##*.}"

openWith () {
    if [[ $(file $FULLFILE |awk '{print $NF}') == 'text' ]]; then
        if [ -z "$LINE" ]; then
            /usr/local/Cellar/macvim/7.4-99/bin/mvim --remote-tab-silent "$FULLFILE" +"$LINE"
        else
            /usr/local/Cellar/macvim/7.4-99/bin/mvim --remote-tab-silent "$FULLFILE"
        fi
    else
        open "$FULLFILE"
    fi
}


openWith "$EXTENSION"
