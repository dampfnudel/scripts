#!/usr/bin/env zsh

# startup script for macOS Emacs
# allow only 1 running instance

# https://www.reddit.com/r/emacs/comments/3b0qpa/if_you_cant_beat_em_join_em_using_systemd_to/
# https://www.reddit.com/r/emacs/comments/1auowq/script_for_using_terminalbased_emacs_as_editor_on/
# https://www.reddit.com/r/emacs/comments/2rietp/dumpemacs_truly_speeds_up_emacs_startup/
# TODO mru
# TODO completion
# TODO man


# latest brew
EMACS_APP=/usr/local/bin/emacs
EMACS_CLIENT=/usr/local/bin/emacsclient
APPLESCRIPT=/usr/bin/osascript
REALPATH=/usr/local/bin/realpath

# #zmodload zsh/zutil
# zparseopts -A ARGUMENTS -p_out: -arg_1:

# # TODO array
# p_out=$ARGUMENTS[--p_out]
# arg1=$ARGUMENTS[--arg_1]

# printf 'Argument p_out is "%s"\n' "$p_out"
# printf 'Argument arg_1 is "%s"\n' "$arg_1" TODO --paramams

function applescript () {
    $APPLESCRIPT -e $1
}

function emacs_running () {
    # check if Emacs is running
    # Emacs always runs as daemon due to:
    # (require 'server)
    # (unless (server-running-p)
    #     (server-start))
    echo $(applescript "tell application \"Emacs\"
        if it is running then
            return 0
        else
            return 1
        end if
    end tell")
}

function attach() {
    echo "Attaching"
    for p in "$@"
    do
        # TODO tmp files
        # either POSIX path of file || $(pwd)/$f
        local f="$($REALPATH $p)"
        echo $f
        $EMACS_CLIENT "$f" &
        # emacsclient starts the server for you if and only if it is not already running
        # $EMACS_CLIENT --alternate-editor="" "$f" &
    done
}

function startup_hook () {
    echo -e "\nMx-start-hacking"
    cat /Users/mbayer/Settings/dotfiles/ascii-art/ambda.txt
    echo ""
}

function start_daemon () {
    startup_hook
    eval "$EMACS_APP --daemon"
}


# exit code style
if [[ $(emacs_running) == 0 ]]
then
    # attaching to running server
    attach "$@"
else
    # starting Emacs daemon and attaching to it
    start_daemon
    # /usr/bin/osascript -e "tell application \"$EMACS_APP\" to activate"
    # create a new frame instead of trying to use the current Emacs frame
    $EMACS_CLIENT -c &
    attach "$@"
fi
