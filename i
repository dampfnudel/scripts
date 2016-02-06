#!/bin/zsh

zmodload zsh/mapfile
FNAME=~/.bookmarks_internet
FLINES=( "${(f)mapfile[$FNAME]}" )

LIST="${mapfile[$FNAME]}" # Not required unless stuff uses it
integer POS=1             # Not required unless stuff uses it
integer SIZE=$#FLINES     # Number of lines, not required unless stuff uses it

# bookmarkfile as dict
typeset -A bms

# read the bookmarks file
# and write key value pairs into the dict
for ITEM in $FLINES;
do
    k=`awk '{print $1}' <<< "$ITEM"`
    v=`awk '{print $2}' <<< "$ITEM"`
    bms+=($k $v)

    (( POS++ ))
done

# for k in "${(@k)bms}"; do
#     echo "$k -> $bms[$k]"
# done

# open the bookmark where bms k == $1
open ${(v)bms[$1]}
