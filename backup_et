#!/bin/bash

START_DATE=$(date +"%s")

DATE=`date +%Y-%m-%d`
# BASE_PATH="/Users/mbayer/Workspace/couchdb-dump/"
BASE_PATH="/VOLUMES/INGOT/et-backup/"
BU_PATH="$BASE_PATH$DATE/"

SCRIPT="/Users/mbayer/Workspace/couchdb-dump/couchdb-backup.sh"

COUCH_TABLES=("events" "nodes" "owners" "pages" "places" "queries" "sessions" "tokens")
URL="http://eventicker.com"
USER="eventicker"
PASSWORD="$1"
PORT="5984"


if [ ! -d "$BU_PATH" ]; then
    echo "creating backup directory $BU_PATH"
    /bin/mkdir -p "$BU_PATH"
fi

for i in "${COUCH_TABLES[@]}"
do
    BU_FILE="$BU_PATH$i.json"

    if [ ! -f "$BU_FILE" ]; then
        echo "executing: "
        CMD="$SCRIPT -b -H $URL -d $i -f $BU_FILE -u $USER -p $PASSWORD -P $PORT"
        #./couchdb-backup.sh -b -H http://eventicker.com -d tokens -f ~/Workspace/couchdb-dump/"$DATE"/tokens.json -u eventicker -p eventickerx15 -P 5984
        echo "$CMD"
        $CMD    # execute

        # fix line endings ^M
        /usr/bin/perl -i -pe's/\r$//' "$BU_FILE"
    else
        echo "$BU_FILE already exists"
    fi
done

cd "$BASE_PATH"
CMD="/usr/bin/tar cfvz $DATE.tar.gz $DATE"
$CMD

END_DATE=$(date +"%s")
DATE_DIFF=$(($END_DATE-$START_DATE))
echo "$(($DATE_DIFF / 60)) minutes and $(($DATE_DIFF % 60)) seconds elapsed."
