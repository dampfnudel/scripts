
print_python_kws () {
    python -c "import keyword
for kw in keyword.kwlist:
print(kw)"
}
mk_zip_bomb () {
    dd if=/dev/zero bs=1M count=10240 | gzip > 10G.gzip
}
list_background_images () {
    local url=$1
    curl $url|awk -F\" '{for(i=0;++i<=NF;){if($i ~ /^http/ && $i !~ "google\|cache:"){print $i}}}'|grep '.*\.\(jpg\|JPG\|png\|PNG\|gif\|GIF\)'
}

escape_spaces () {
echo "${(q)1}"
}
# print a directory tree
dir_tree () {
ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
}

# fbr - checkout git branch (including remote branches)
f_git_checkout () {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
    fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
f_git_checkout_tag () {
    local tags branches target
    tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
f_git_checkout_commit () {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
        commit=$(echo "$commits" | fzf --tac +s +m -e) &&
        git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
f_git_log () {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
    (grep -o '[a-f0-9]\{7\}' | head -1 |
    xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
    {}
    FZF-EOF"
}

# pick a container id from all containers
f_docker_container_id () {
    local selection c_id
    selection=$(docker ps -a | fzf --reverse --header-lines=1 --prompt="🐳  ")
    c_id=$(echo $selection | awk '{print $1}')
    echo $c_id | pbcopy
    echo "copied:"
    echo $c_id
}

f_docker_exec_select () {
    local selection c_id cmd
    selection=$(docker ps | fzf --reverse --header-lines=1 --prompt="🐳  ")
    c_id=$(echo $selection | awk '{print $1}')
    cmd="docker exec -it $c_id /bin/bash"
    echo $cmd
    eval $cmd
}
alias docker_shell='f_docker_exec_select'

# pick a container id from all running containers
f_docker_container_running_id () {
    local selection c_id
    selection=$(docker ps | fzf --reverse --header-lines=1 --prompt="🐳  ")
    c_id=$(echo $selection | awk '{print $1}')
    echo $c_id | pbcopy
    echo "copied:"
    echo $c_id
}

# pick an image name
f_docker_image_name () {
    local selection c_id
    selection=$(docker ps -a | fzf --reverse --header-lines=1 --prompt="🐳  ")
    c_id=$(echo $selection | awk '{print $2}')
    echo $c_id | pbcopy
    echo "copied:"
    echo $c_id
}

# trac {
# cartman wrapper
trac () {
    $WORKON_HOME/python2.7.5/bin/cm "$@" 2>/dev/null
}

# comment on a ticket
trac_comment () {
    # trac_comment {ticket_nr} "{comment}"
    trac comment "$1" -m "$2"
}

# view ticket status
trac_status () {
    trac status "$@"
}

# accept a ticket
trac_accept () {
    trac status "$1" accept
}

# view a ticket by nr
# -o -> open in browser
trac_view () {
    local ticket_nr
    ticket_nr=$1
    if [[ ! $ticket_nr == '' ]]; then
        local ticket_url
        ticket_url=https://trac.inquant.de/regioyal/ticket/$ticket_nr

        if [[ "$2" == "-o" ]]; then
            echo "🐾  $ticket"
            echo "🔗  $ticket_url"
            open https://trac.inquant.de/regioyal/ticket/$ticket_nr
        else
            local ticket_description
            ticket_description=`trac view $ticket_nr`
            echo "🐾  $ticket_description"
            echo ""
            echo ""
            echo "------------------------------------------------"
            echo "🔗  $ticket_url"
        fi
    fi
}

# search ticket titles via https://pypi.python.org/pypi/cartman/0.2.3
trac_ticket () {
    local ticket ticket_nr
    # sort numerical
    ticket=$(trac report 3 | sort -t '#' -k 2n | fzf)
    ticket_nr=`echo $ticket | awk '{print $1}' | sed 's/[^0-9]*//g'`

    if [[ ! $ticket_nr == '' ]];then
        trac_view $ticket_nr $1
    fi
}

# search tickets (trac_search "404 pages" -o)
trac_search () {
    local ticket ticket_nr
    ticket=$(trac search "$1" | fzf)
    ticket_nr=`echo $ticket | awk '{print $1}' | sed 's/[^0-9]*//g'`

    if [[ ! $ticket_nr == '' ]];then
        local last_param
        eval last_param=\$$#
        if [[ $last_param == '-o' ]];then
            trac_view $ticket_nr $last_param
        else
            trac_view $ticket_nr
        fi
    fi
}
# }

# print time logged in
print_uptime () {
    last | grep `whoami` | grep -v logged | cut -c61-71 | sed -e 's/[()]//g' | awk '{ sub("\\+", ":");split($1,a,":");if(a[3]){print a[1]*60*60+a[2]*60+a[3]} else {print a[1]*60+a[2] }; }' | paste -s -d+ - | bc | awk '{printf "%dh:%dm:%ds\n",$1/(60*60),$1%(60*60)/60,$1%60}'
}

# escape spaces
esc () {
    echo ${(q)@}
}

# copy the last command to clipboard
copy_last_cmd () {
    # echo "!!" | pbcopy
    history | tail -1 | awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}' | pbcopy
}

    pomodoro () {
        # TODO: tags, exercises, postpone
        # Basso.aiff  Blow.aiff  Bottle.aiff  Frog.aiff  Funk.aiff  Glass.aiff  Hero.aiff  Morse.aiff  Ping.aiff  Pop.aiff  Purr.aiff  Sosumi.aiff  Submarine.aiff  Tink.aiff
        local title="Pomodoro"
        local subtitle="time for a break"
        local soundname="Hero"
        if [[ "$1" == "" ]]; then
            local notification="a task"
        else
            local notification="$1"
        fi
        local timestamp=$(date +%d.%m.%Y-%H:%M:%S)
        # TODO: display end time
        echo "$timestamp\t$notification""\r"
        echo "$timestamp\t$notification""\r" >> ~/.pomodoro

        local secs=$((1))
        # display a timer
        while [ $secs -gt 0 ]; do
            # TODO: format minutes
            echo -ne "$secs\033[0K\r"
            sleep 1
            : $((secs--))
        done
        echo "display notification \"$notification\" with title \"$title\" subtitle \"$subtitle\" sound name \"$soundname\""
        osascript -e "display notification \"$notification\" with title \"$title\" subtitle \"$subtitle\" sound name \"$soundname\""
    }

    pomodoro_today () {
        local pomodoros=$(grep -o "$(date +%d.%m.%Y)" ~/.pomodoro | wc -l|awk '{print $1}')
        echo "$pomodoros pomodoros today: ${(l:$pomodoros::🍅:)}\n"
        cat ~/.pomodoro | grep "$(date +%d.%m.%Y)" --color=never | cut -c 12-
    }

    starwars () { telnet towel.blinkenlights.nl }

    # mandelbrot
    mandelbrot () {
        local lines columns colour a b p q i pnew
        ((columns=COLUMNS-1, lines=LINES-1, colour=0))
        for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
            for ((a=-2.0; a<=1; a+=3.0/columns)) do
                for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
                    ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
                done
                ((colour=(i/4)%8))
                echo -n "\\e[4${colour}m "
            done
            echo
        done
    }

    # open a url
    op () {
        typeset -A mapping
        mapping=(
        google https://www.google.de/
        spotify https://play.spotify.com/collection/songs
        )
        open $mapping[$@]
    }
