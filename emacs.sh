#!/usr/bin/env zsh

# emacs
# MATCHES="$(ps aux | grep "Emacs --daemon" | wc -l)"
# echo "${MATCHES: -1}"
# if [[ "${MATCHES: -1}" == 1 ]]
# then
#     echo "starting server"
#     emacs --daemon
# fi

# echo "attaching"
# emacsclient -c "$@" &

# MATCHES="$(ps aux | grep "Emacs -daemon" | wc -l)"
# # echo "${MATCHES: -1}"
# case "${MATCHES: -1}" in

# 1)  echo "Mx-start-hacking\n"
#     cat /Users/mbayer/Settings/dotfiles/lambda.txt
#     echo "\nStarting server"
#     emacs -daemon
#     echo "Attaching"
#     emacsclient -c "$@" &
#     ;;
# 2)  emacsclient "$@" &
#     ;;
# esac
MATCHES="$(ps aux | grep "Emacs -daemon" | wc -l)"
# echo "${MATCHES: -1}"
case "${MATCHES: -1}" in

1)  echo "Mx-start-hacking\n"
    cat /Users/mbayer/Settings/dotfiles/lambda.txt
    echo "\nStarting server"
    emacs -daemon
    echo "Attaching"
    emacsclient -c "$@" &
    ;;
2)  exec emacsclient --alternate-editor="" "$@" &
    ;;
esac

RUNNING=$(/usr/bin/osascript -e "tell application \"Emacs\"
    if it is running then
      return \"\n emacs is running\"
    else
      return \"not running\"
    end if
end tell")
echo "$RUNNING"


# #!/usr/bin/env bash

# # start emacs

# # TODO handle args

# # always use latest brew version
# emacs_app=/usr/local/bin/emacs
# # shopt -s nullglob
# # versions=(/usr/local/Cellar/emacs/*/)
# # shopt -u nullglob
# # latest_version=${versions[${#versions[@]}-1]}
# # emacs_app="$latest_version""Emacs.app"

# if [ ! -x $emacs_app ]; then
#     echo "Emacs.app not found" >&2
#     exit 1
# fi

# # start emacs in background
# /usr/bin/osascript -e "tell application \"$emacs_app\" to activate" &

# if [ $# -gt 0 ]; then
#     tempfiles=()

#     while IFS= read -r filename; do
#         # create tempfiles if neccessary
#         if [ ! -f "$filename" ]; then
#             tempfiles+=("$filename")
#             /usr/bin/touch "$filename"
#         fi

#         # resolve relative paths
#         file=$(realpath "$filename")
#         /usr/bin/osascript -e "tell application \"$emacs_app\" to open POSIX file \"$file\""> /dev/null
#     done <<< "$(printf '%s\n' "$@")"

#     for tempfile in "${tempfiles[@]}"; do
#         [ ! -s "$tempfile" ] && /bin/rm "$tempfile"
#     done
# fi
