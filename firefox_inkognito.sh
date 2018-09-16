#!/bin/sh -e

# brute force a Firefox private session
# https://nullprogram.com/blog/2018/09/06/

DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
mkdir -p -- "$DIR"
TEMP="$(mktemp -d -- "$DIR/firefox-XXXXXX")"
trap "rm -rf -- '$TEMP'" INT TERM EXIT
/Applications/Firefox.app/Contents/MacOS/firefox -profile "$TEMP" -no-remote "$@"
