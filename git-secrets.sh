#!/bin/bash

declare -A EXPRESSIONS=( [AWS]='AKIA[0-9A-Z]{16}' [RKCS8]='-----BEGIN PRIVATE KEY-----' [RSA]='-----BEGIN RSA PRIVATE KEY-----' [GITHUB]='[g|G][i|I][t|T][h|H][u|U][b|B].*[0-9a-zA-Z]{35,40}' [SSH]='-----BEGIN OPENSSH PRIVATE KEY-----' [FACEBOOK]='[f|F][a|A][c|C][e|E][b|B][o|O][o|O][k|K].*[0-9a-f]{32}' [TWITTER]='[t|T][w|W][i|I][t|T][t|T][e|E][r|R].*[0-9a-zA-Z]{35,44}' [PGP]='-----BEGIN PGP PRIVATE KEY BLOCK-----' [SLACK]='xox[baprs]-.*' [STRIPE]='[s|S|p|P][k|K]_(test|live)_[0-9a-zA-Z]{10,32}' [HEROKU]='[h|H][e|E][r|R][o|O][k|K][u|U].*[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}' [GOOGLE]='client_secret:[a-zA-Z0-9-_]{24}' [PGPBLOCK]='-----BEGIN PGP PRIVATE KEY BLOCK-----.*' [GOOGLEOAUTH2]='[c|C][l|L][i|I][e|E][n|N][T|T][_][s|S][e|E][c|C][r|R][e|E][t|T].*[:].*[a-zA-Z0-9-_]{24}' [SSHEC]='-----BEGIN EC PRIVATE KEY-----.*' [SSHDSA]='-----BEGIN DSA PRIVATE KEY-----.*' [TWITTEROAUTH2]='[t|T][w|W][i|I][t|T][t|T][e|E][r|R].*.[0-9a-zA-Z]{35,44}' [FACEBOOKOAUTH2]='[f|F][a|A][c|C][e|E][b|B][o|O][o|O][k|K].*.[0-9a-f]{32}' [APPSECRET]='[a|A][p|P][p|P][s|S][e|E][c|C][r|R][e|E][t|T].*.[0-9a-zA-Z]{32,45}' [PASSWORD]='.*[p|P][a|A][s|S][s|S][w|W][o|O][r|R][d|D].*=.*' [GITHUBOAUTH2]='[g|G][i|I][t|T][h|H][u|U][b|B].*[c|C][l|L][i|I][e|E][n|N][T|T][s|S][e|E][c|C][r|R][e|E][t|T].*[0-9a-zA-Z]{35,40}' )

BASE64_CHARS="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
HEX_CHARS="1234567890abcdefABCDEF"

#echo "$1"
if [ -z "$1" ] ; then
	echo "USAGE: /bin/sh $0 file"
	echo "	     /bin/sh $0 dir"
	echo "	     /bin/sh $0 *"
	exit 1
fi

#echo "1"
#echo "$1"
#AWS=$(egrep -r -E -i 'AKIA[0-9A-Z]{16}')
#if [[ -z "$AWS" ]] ; then
#	echo "AWS Token(s) found: "
#	echo "AWS"
#fi

#echo "2"
#echo ${#EXPRESSIONS[@]}
for KEY in "${!EXPRESSIONS[@]}"
do
	result=$(egrep -r '"'${EXPRESSIONS[$KEY]}'"' $1 2>/dev/null)
	if [[ -n "$result" ]] ; then
		echo "$KEY :"
		echo "$result"
	fi
done
