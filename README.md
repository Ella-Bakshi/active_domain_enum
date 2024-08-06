# active_domain_enum
Active Domain Enumeration via Sublister and Wayback Machine
enter 
chmod +x domain_enum.sh
then 
./domain_enum.sh
then enter domain name


If any problem like  "-bash: ./domain_enum.sh: cannot execute: required file not found" arises 
Try "dos2unix domain_enum.sh" and run again


Required Packages commands

SubFinder:- go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
Httpx:-     go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
Curl:-      sudo apt-get install curl -y
Jq:-        sudo apt-get install jq -y 
