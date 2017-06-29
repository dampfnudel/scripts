#!/bin/bash

voices=(
    Agnes
    Kathy
    Princess
    Vicki
    Victoria
    Alex
    Bruce
    Fred
    Junior
    Ralph
    Albert
    'Bad News'
    Bahh
    Bells
    Boing
    Bubbles
    Cellos
    Deranged
    'Good News'
    Hysterical
    'Pipe Organ'
    Trinoids
    Whisper
    Zarvox
)

echo -e "💬\tyou type I speak. Exit with ^C (Ctrl-C)."
echo -e "\tChange the voice whith 'voice {voicename}'"
echo -e "\tavailable voicenames:"
for i in "${voices[@]}"
do
    echo -e "\t\t$i"
done
echo ""

voice="Princess"
while true;
do
    cmd=0
    now=$(date +"%T")
    echo -n "[ 🕙 $now ] [ 💬 $voice  ] 📝  -> 🔈  "
    read sentence

    for i in "${voices[@]}"
    do
        if [ "voice $i" == "$sentence" ]; then
            cmd=1
            voice="$i"
            msg="[ Changed voice to $i]"
            echo $msg
            say -v "$voice" $msg
        fi
    done
    if [ $cmd -eq 0 ]; then
        say -v "$voice" "$sentence"
    fi
done
