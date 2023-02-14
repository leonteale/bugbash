#!/bin/bash

# BugBash - Menu System


#############
#  Colours  #
#############

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

#############
#  Headers  #
#############

########### Define function for menu-header
function menu-header {
    clear
    # Title
    echo -e "${BLUE}BugBash - Menu System${NC}"
    echo "---------------------"

    # Client name
    if [[ -n "$client_name" ]]; then
        echo "Client name:   $client_name"
    fi

    # Client folder and domain
    if [[ -n "$WD" && -n "$Domain" ]]; then
        if [[ -f "${HOME}/.bugbash/${client_name}/${client_name}.txt" ]]; then
            Domain=$(cat "${HOME}/.bugbash/${client_name}/${client_name}.txt")
        else
            Domain="No domain set"
        fi

        if [[ -f "${WD}/subdomains.${Domain}.txt" ]]; then
            num_subdomains=$(wc -l < "${WD}/subdomains.${Domain}.txt")
            echo "Client folder: $WD"
            echo -e "Domain:        $Domain (subdomains found: ${GREEN}$num_subdomains${NC})"
        else
            echo "Client folder: $WD"
            echo "Domain:        $Domain (no subdomains saved)"
        fi
    elif [[ -n "$WD" ]]; then
        echo "Client folder: $WD"
    elif [[ -n "$Domain" ]]; then
        echo "Domain:        $Domain"
    fi

    echo "---------------------"
}



#############
# main menu #
#############


#start script menu
scriptstartoption1="${GREEN}Load${NC} - List existing targets"
scriptstartoption2="${GREEN}New${NC} - Start a new scan"


function scriptstart-menu {
  echo -e "${YELLOW}Select an option:${NC}"
  echo -e "1) $scriptstartoption1"
  echo -e "2) $scriptstartoption2"
  echo -e "${RED}Q) Quit${NC}"
  echo
  read -rp "Enter selection: " choice
}
function scriptstart {
# Call startscript-menu function
while true; do
  menu-header 
  scriptstart-menu
  case $choice in
    1) scriptstartoption1 ;break;;
    2) scriptstartoption2 ;break;;
    Q|q) break ;;
    *) echo -e "${RED}Invalid option. Press any key to try again.${NC}"; read -n1 -r ;;
  esac
done
}


# Define function for scriptstartoption 1
function scriptstartoption1 {
  # Change the current working directory to the directory where the script was run from
  cd "$(dirname "$0")"
  # Import the newscan option script
  source load.sh
}


# Define function for Option 2
function scriptstartoption2 {
  # Change the current working directory to the directory where the script was run from
  cd "$(dirname "$0")"
  source new.sh
}

scriptstart

############
# sub menu #
############

# submenu options
suboption1="${GREEN}Update target domain${NC} - Add a new domain (overwite existing domain)"
suboption2="${GREEN}Sub Domain Scan${NC} - Perform a subdomain scan"
suboption3="${GREEN}Subdomain takeover${NC} - Perform subdomain takeover"
suboption4="${GREEN}blank${NC} - Blank"

function submenu {
  menu-header
  echo -e "${YELLOW}Select an option:${NC}"
  echo -e "1) $suboption1"
  echo -e "2) $suboption2"
  echo -e "3) $suboption3"
  echo -e "${RED}Q) Quit${NC}"
  echo
  read -rp "Enter selection: " choice
}

# Define function for Option 1
function suboption1 {
  # Change the current working directory to the directory where the script was run from
  cd "$(dirname "$0")"
  # Import the subdomain scan option
  source addnewdomain.sh
}

# Define function for Option 2
function suboption2 {
  # Change the current working directory to the directory where the script was run from
  cd "$(dirname "$0")"
  # Import the subdomain scan option
  source subdomainscan.sh
   read -n1 -r -p "Press any key to continue..."
}

# Define function for Option 2
function suboption3 {
  # Change the current working directory to the directory where the script was run from
  cd "$(dirname "$0")"
  # Import the subdomain scan option
  source subdomaintakeover.sh
   read -n1 -r -p "Press any key to continue..."
}

# Call menu function
while true; do
  submenu
  case $choice in
    1) suboption1 ;;
    2) suboption2 ;;
    3) suboption3 ;;
    Q|q) break ;;
    *) echo -e "${RED}Invalid option. Press any key to try again.${NC}"; read -n1 -r ;;
  esac
done