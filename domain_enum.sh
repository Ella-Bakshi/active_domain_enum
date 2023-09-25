#!/bin/bash

# Read the domain name from the user
echo "Enter your Domain Name: "
read domain

# Check for empty domain input
if [ -z "$domain" ]; then
  echo "Domain name cannot be empty!"
  exit 1
fi

# Run subfinder to get subdomains, assuming that '-o' is the correct option for output file
subfinder -d $domain -o ${domain}_subdomains.txt

# Check the subdomains are alive using httpx, assuming that '--silent' is the correct option for silent mode
cat ${domain}_subdomains.txt | httpx --silent -o ${domain}_alive.txt

# Fetch historical domains from web.archive.org
curl "http://web.archive.org/cdx/search/cdx?url=*.$domain/*&output=json&fl=original&collapse=urlkey" -s -k --insecure --path-as-is | jq -r '.[] | .[0]' | sort -u | tee -a ${domain}_archive.txt

# Merge, sort, and get unique domains from both files and check if they are alive
cat ${domain}_alive.txt ${domain}_archive.txt | sort -u | httpx --silent -o ${domain}_final.txt

# Remove all other generated files
rm -rf ${domain}_alive.txt ${domain}_archive.txt ${domain}_subdomains.txt

# Final message
echo "All unique functioning alive links are saved in ${domain}_final.txt"
