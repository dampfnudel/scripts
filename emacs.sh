#!/usr/bin/env bash

# startup script for macOS Emacs
# allow only 1 running instance

function emacs_running () {
    # check if Emacs is running
    # Emacs always runs as daemon due to:
    # (require 'server)
    # (unless (server-running-p)
    #     (server-start))
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
    # attaching to running server
    emacsclient "$@" &
else
    # starting Emacs daemon and attaching to it
    echo "Mx-start-hacking\n"
    cat /Users/mbayer/Settings/dotfiles/lambda.txt
    echo "\nStarting server"
    emacs --daemon
    echo "Attaching"
    emacsclient -c "$@" &
fi
