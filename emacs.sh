#!/usr/bin/env bash

function emacs_running () {
    local IS_RUNNING=$(/usr/bin/osascript -e "tell application \"Emacs\"
        if it is running then
            return 0
        else
            return 1
        end if
    end tell")
    echo "$IS_RUNNING"
}

if [[ $(emacs_running) == 0 ]]
then
    emacsclient "$@" &
else
    echo "Mx-start-hacking\n"
    cat /Users/mbayer/Settings/dotfiles/lambda.txt
    echo "\nStarting server"
    emacs --daemon
    echo "Attaching"
    emacsclient -c "$@" &
fi
