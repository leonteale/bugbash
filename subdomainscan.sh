# check if subfinder is installed
if ! which subfinder >/dev/null 2>&1; then
  echo "subfinder not found, installing..."
  go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
fi

# check if subfinder is installed and run it
if which subfinder >/dev/null 2>&1; then
  echo "Running subfinder against $Domain"
  subfinder -d $Domain -v -o "${WD}/subdomains.${Domain}.txt"
else
  echo "subfinder not found, please install it manually."
fi
