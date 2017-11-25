#!/usr/bin/env bash

# start emacs

# TODO handle args

# always use latest brew version
shopt -s nullglob
versions=(/usr/local/Cellar/emacs/*/)
shopt -u nullglob
latest_version=${versions[${#versions[@]}-1]}
emacs_app="$latest_version""Emacs.app"

if [ ! -x $emacs_app ]; then
    echo "Emacs.app not found" >&2
    exit 1
fi

# start emacs in background
/usr/bin/osascript -e "tell application \"$emacs_app\" to activate" &

if [ $# -gt 0 ]; then
    tempfiles=()

    while IFS= read -r filename; do
        # create tempfiles if neccessary
        if [ ! -f "$filename" ]; then
            tempfiles+=("$filename")
            /usr/bin/touch "$filename"
        fi

        # resolve relative paths
        file=$(realpath "$filename")
        /usr/bin/osascript -e "tell application \"$emacs_app\" to open POSIX file \"$file\""> /dev/null
    done <<< "$(printf '%s\n' "$@")"

    for tempfile in "${tempfiles[@]}"; do
        [ ! -s "$tempfile" ] && /bin/rm "$tempfile"
    done
fi
