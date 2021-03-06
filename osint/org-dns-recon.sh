$!/bin/bash

# depends: curl, jq

mkdir ${1}
cd ${1}

curl --request GET --url 'https://api.securitytrails.com/v1/domain/oracle.com?apikey='${1}

#
##IP Lookups
#
ASNWhoisIP() {
	printf "$found_route" "$found_asn" "$found_asname"
}

#
##NS Lookups
#
DigNS(){
	dig -t ns +short <target.dom>
	dig -t soa +short <target.dom>
}

ZoneTransfer(){
	dig -t axfr xom.com +short ${1}
}

#
##ASN Lookups
#
LookupASNAndRouteFromIP(){
	#populate fields necessary for ASN Lookup
	found_route=""
    found_asn=""
    found_asname=""
    output=$(whois -h whois.cymru.com " -f -p $1" | sed -e 's/\ *|\ */|/g')
    found_asn=$(echo $output | awk -F'[|]' {'print $1'})
    found_asname=$(echo $output | awk -F'[|]' {'print $4'})
    found_route=$(echo $output | awk -F'[|]' {'print $3'})
}

#
##whois lookups
ASNWhoisIP() {
	printf "$found_route" "$found_asn" "$found_asname"
}

WhoisASN(){
	whois -h whois.cymru.com " -f -w -c -p as$1" | sed -e 's/\ *|\ */|/g' | awk -F '[|]' {'print $3'}
}

#dns lookups
get_dns_spf() {
   dig @8.8.8.8 +short txt "$1" |
   tr ' ' '\n' |
   while read entry; do
      case "$entry" in
             ip4:*) echo ${entry#*:} ;;
         include:*) get_dns_spf ${entry#*:} ;;
      esac
   done
}



#enumerate domain(){
