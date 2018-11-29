#!/bin/sh -e

# brute force a Chrome private session
# https://nullprogram.com/blog/2018/09/06/

DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
mkdir -p -- "$DIR"
TEMP="$(mktemp -d -- "$DIR/chromium-XXXXXX")"
trap "rm -rf -- '$TEMP'" INT TERM EXIT
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir="$TEMP" \
         --no-default-browser-check \
         --no-first-run \
         "$@" >/dev/null 2>&1
