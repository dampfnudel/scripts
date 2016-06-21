#!/bin/bash

FILES=$1
BASENAME=$2
DRY=$3
i=1
for f in `ls $FILES`; do
    # skip folders
    if [[ -f $f ]]
    then
        # get the extension
        filename=$(basename "$f")
        extension="${filename##*.}"

        # show what would happen
        echo "$f ->" `printf %s_%03d.%s $BASENAME $i $extension`

        if [[ "$DRY" != "dryrun" ]]
        then
            echo "$f ->" `printf %s_%03d.%s $BASENAME $i $extension`
            # rename
            mv "$f" `printf %s_%03d.%s $BASENAME $i $extension` 2>/dev/null || true
        fi
    fi

    i=$((i + 1))
done
