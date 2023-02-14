# check if subfinder is installed
if ! which subfinder >/dev/null 2>&1; then
  echo "subfinder not found, installing..."
  sudo apt-get -y install subfinder
fi

# check if subfinder is installed and run it
if which subfinder >/dev/null 2>&1; then
  echo "Running subfinder against $Domain"
  subfinder -d $Domain -all -v -o "${WD}/subdomains.${Domain}.txt"
else
  echo "subfinder not found, please install it manually."
fi