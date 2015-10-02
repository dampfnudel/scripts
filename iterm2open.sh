#!/bin/bash

# open textfiles with "mvim --remote-tab-silent {file} +{linenumber}". Open other files with "open"

FULLFILE="$1"
LINE="$2"

FILENAME=$(basename "$FULLFILE")
EXTENSION="${FILENAME##*.}"
# FILENAME="${FILENAME%.*}"

TEXTEXTENSIONS=("txt" "md" "markdown" "tracwiki" "json" "csv" "py" "html" "css" "js" "sh" "zsh")


containsElement () {
    local e
    local ARRAY="${@:2}"
    for e in $ARRAY; do
        [[ "$e" == "$1" ]] && return 1
    done
    return 0
}


isTextFile () {
    $(containsElement "$1" "${TEXTEXTENSIONS[@]}")
    isText=$?

    if [ "$isText" == "1" ]; then
        # echo "text"
        return 1
    else
        # echo "no text"
        return 0
    fi
}


openWith () {
    $(isTextFile "$1")
    isText=$?

    if [ "$isText" == "1" ]; then
        if [ -z "$LINE" ]; then
            /usr/local/Cellar/macvim/7.4-76/bin/mvim --remote-tab-silent "$FULLFILE" +"$LINE"
        else
            /usr/local/Cellar/macvim/7.4-76/bin/mvim --remote-tab-silent "$FULLFILE"
        fi
    else
        open "$FULLFILE"
    fi
}


openWith "$EXTENSION"
