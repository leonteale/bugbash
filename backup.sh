#!/bin/bash

# BugBash - Menu System
# Insert any additional comments or description here

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

# Define menu options
option1="${GREEN}New Scan${NC} - Set up new scan"
option2="${GREEN}Sub Domain Scan${NC} - Perform a subdomain scan"
option3="${GREEN}Option 3${NC} - Description of option 3"
option4="${GREEN}Option 4${NC} - option 4"

# Define function for menu
function menu {
  clear
echo -e "${BLUE}BugBash - Menu System${NC}"
if [[ -n "$client_name" ]]; then
  echo "---------------------"
  echo "Client name:   $client_name"
fi
if [[ -n "$WD" ]]; then
  echo "Client folder: $WD"
fi
if [[ -n "$Domain" ]]; then
  if [[ -f "${WD}/subdomains.${Domain}.txt" ]]; then
    num_subdomains=$(wc -l < "${WD}/subdomains.${Domain}.txt")
    echo "Domain:        $Domain (subdomains found: $num_subdomains)"
  else
    echo "Domain:        $Domain (no subdomains saved)"
  fi
fi
echo "---------------------"

  echo -e "${YELLOW}Select an option:${NC}"
  echo -e "1) $option1"
  echo -e "2) $option2"
  echo -e "3) $option3"
  echo -e "4) $option4"
  echo -e "${RED}Q) Quit${NC}"
  echo
  read -rp "Enter selection: " choice
}

# Define function for Option 1
function option1 {
  # Change the current working directory to the directory where the script was run from
  cd "$(dirname "$0")"
  # Import the newscan option script
  source newscan.sh
}


# Define function for Option 2
function option2 {
  # Change the current working directory to the directory where the script was run from
  cd "$(dirname "$0")"
  # Import the subdomain scan option
  source subdomainscan.sh
}

# Define function for Option 3
function option3 {
  # Insert code for Option 3 here
  echo -e "${CYAN}You have selected Option 3${NC}"
  read -n1 -r -p "Press any key to continue..."
}

# Define function for Option 4
function option4 {
  # Insert code for Option 4 here
  echo -e "${YELLOW}You have selected Option 4${NC}"
  read -n1 -r -p "Press any key to continue..."
}

# Call menu function
while true; do
  menu
  case $choice in
    1) option1 ;;
    2) option2 ;;
    3) option3 ;;
    4) option4 ;;
    Q|q) break ;;
    *) echo -e "${RED}Invalid option. Press any key to try again.${NC}"; read -n1 -r ;;
  esac
done

