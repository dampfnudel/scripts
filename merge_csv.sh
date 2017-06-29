#!/usr/bin/env bash

# merge csv files

BASENAME=$1                               # pattern the files share eg foo for foo-01.csv, foo-02.csv...
OutFileName=$BASENAME.csv                       # Fix the output name
i=0                                       # Reset a counter
for filename in ./$BASENAME*.csv; do 
    if [ "$filename"  != "$OutFileName" ] ;      # Avoid recursion 
    then 
        if [[ $i -eq 0 ]] ; then 
            echo "writing header"
            head -1  $filename >   $OutFileName # Copy header if it is the first file
        fi
        echo "merging $filename"
        tail -n +2  $filename >>  $OutFileName # Append from the 2nd line each file
        i=$(( $i + 1 ))                        # Increase the counter
    fi
done

echo "merged to $OutFileName"
