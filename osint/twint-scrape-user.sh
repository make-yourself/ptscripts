#!/bin/bash

#usage twint-scrape-all.sh targetuname
#usage twint-scrape-all.sh targetuname (json,csv,txt) /path/to/output

if [ -z "$2" ]; then
	2="txt"
	if [ -z "$1" ]; then
		echo "knock knock!"
		echo "who's there?"
		echo "not a user. goodbye"
	fi
fi

mkdir ${1}
cd ${1}
twint -u ${1} -o ${3}${1}.twint.${2}
twint -u ${1} -o ${3}${1}.twint-followers.${2} --followers --users-full
twint -u ${1} -o ${3}${1}.twint-following.${2} --following --users-full
twint -u ${1} -o ${3}${1}.twint-retweets.${2} --retweets
twint -u ${1} -o ${3}${1}.twint-replies.${2} --replies
twint -u ${1} -o ${3}${1}.twint-favorites.${2} --favorites
twint -u ${1} -o ${3}${1}.twint-profile-full.${2} --profile-full --stats
twint --to ${1} -o ${3}${1}.twint.${2}
twint -u ${1} -o ${3}${1}.twint-media.${2} --media
twint -u ${1} -o ${3}${1}.twint-contacts.${2} --phone --email
twint --all ${1} -o ${3}${1}.twint.${2} --stats
