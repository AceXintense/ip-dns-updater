. ./app/config.sh
CACHE_FILE="ip.cache"

if [ ! -f "$CACHE_FILE" ]; then
	touch $CACHE_FILE
fi

log "Getting IP"
IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
STORED_IP=$(cat $CACHE_FILE)

#Check to see if the stored IP is different than the IP that the openDNS resolver is returning.
if [ "$STORED_IP" = "$IP" ]; then
        log "IP is the same skipping"
else
	log "Updating IP"

	#Providers - Manipulate the DNS records on using CLI scripts or CURL.
	if [ "$PROVIDER" = "digital-ocean" ]; then
		. ./providers/digital-ocean.sh
	else
		echo "$PROVIDER is not currently supported."
	fi

	#Notifiers - Notify a specific user or a team.
	if [ "$PUSHCUT_URL" != "" ]; then
		. ./notifiers/pushcut.sh
	fi
	echo ""

	log "Updated IP from ($STORED_IP) to ($IP)"
	echo ""

	#Store the IP on the drive so that we can do a difference check in the future.
	echo $IP > $CACHE_FILE
fi
