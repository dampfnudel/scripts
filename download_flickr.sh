#!/usr/bin/env sh

# download flickr images in max quality from a url list

while read line; do
  curl $line|awk -F\" '{for(i=0;++i<=NF;){if($i ~ /^http/ && $i !~ "google\|cache:"){print $i}}}'|grep _k>>images.txt
done <megane-wakui.txt

while read line; do wget $line; done <images.txt
