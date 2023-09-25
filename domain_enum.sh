#!/bin/bash

# Read the domain name from the user
echo "Enter your Domain Name: "
read domain

# Check for empty domain input
if [ -z "$domain" ]; then
  echo "Domain name cannot be empty!"
  exit 1
fi

# Run subfinder and httpx to get alive subdomains
subfinder -d $domain -all -cs -silent | httpx -silent -title -wc -sc -cl -ct -location -web-server -asn -o ${domain}_alive.txt

# Fetch historical domains from web.archive.org
curl "http://web.archive.org/cdx/search/cdx?url=*.$domain/*&output=json&fl=original&collapse=urlkey" -s -k --insecure --path-as-is | sed 's/\["//g'| sed 's/"\],//g' | sort -u | tee -a ${domain}_archive.txt

# Merge, sort, and get unique domains from both files and check if they are alive
cat ${domain}_alive.txt ${domain}_archive.txt | sort -u | httpx -silent -o ${domain}_final.txt

# Remove all other generated files
rm -rf ${domain}_alive.txt ${domain}_archive.txt

# Final message
echo "All unique functioning alive links are saved in ${domain}_final.txt"
