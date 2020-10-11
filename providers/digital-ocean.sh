curl -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $API_TOKEN" -d "{\"data\":\"$IP\"}" "https://api.digitalocean.com/v2/domains/$DOMAIN/records/$RECORD_ID"
