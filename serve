#!/bin/bash

# download link
echo 'download: '
ip=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2)
printf "\e[31m%s:8080\e[0m\n" $ip
# serve the given file
while true; do { echo -e 'HTTP/1.1 200 OK\r\n'; cat $1; } | nc -l 8080; done
