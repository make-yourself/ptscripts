#!/usr/bin/env bash

#
# ./jwt-gen.sh
#
secret='SECRETS HERE COME PUT YOUR SECRETS HERE'

# Static header fields.
header='{
	"typ": "JWT",
	"alg": "HS256"
}'

# jq sets dynamic `iat` and `exp` fields on header at current datetime.
# `iat` is set to now, and `exp` is now + 1 second.
header=$(
	echo "${header}" | jq --arg time_str "$(date +%s)" \
	'
	($time_str | tonumber) as $time_num
	| .iat=$time_num
	| .exp=($time_num + 1)
	'
)

payload='{
	"id": 0,
	"username": "Administrator"
}'

# `tr` URLencodes output from base64
b64Enc()
{
	declare input=${1:-$(</dev/stdin)}
	printf '%s' "${input}" | base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n'
}

jsonify() {
	declare input=${1:-$(</dev/stdin)}
	printf '%s' "${input}" | jq -c .
}

#hmac sha256
hs256Sign()
{
	declare input=${1:-$(</dev/stdin)}
	printf '%s' "${input}" | openssl dgst -binary -sha256 -hmac "${secret}"
}

headerb64=$(echo "${header}" | jsonify | b64Enc)
payloadb64=$(echo "${payload}" | jsonify | b64Enc)

headerPayload=$(echo "${headerb64}.${payloadb64}")
sig=$(echo "${headerPayload}" | hs256Sign | b64Enc)

echo "${headerPayload}.${sig}"