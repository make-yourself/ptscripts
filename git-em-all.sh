#!/bin/bash

#scipt to close all repositories from a list of links, e.g.  json organization's repositories
if $# > 1; then
	printf "USAGE: sh ./gitemall.sh /dir/file.ext"
	exit
fi
printf '%s\n' "$1"
input="$1"
while IFS= read -r var
do
	git clone $var
done <"$input"
