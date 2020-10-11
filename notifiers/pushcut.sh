curl -X POST -d "{\"text\": \"Home IP address has changed from ($STORED_IP) to ($IP)\", \"title\": \"Home IP Changed\"}" -H "Content-Type: application/json" "$PUSHCUT_URL"
