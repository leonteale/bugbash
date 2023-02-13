#!/bin/bash

# BugBash - Menu System
# Insert any additional comments or description here

# Define menu options
option1="Option 1 - Description of option 1"
option2="Option 2 - Description of option 2"
option3="Option 3 - Description of option 3"

# Define function for menu
function menu {
  clear
  echo "BugBash - Menu System"
  echo "---------------------"
  echo "Select an option:"
  echo "1) $option1"
  echo "2) $option2"
  echo "3) $option3"
  echo "Q) Quit"
  echo
  read -rp "Enter selection: " choice
}

# Define function for Option 1
function option1 {
  # Insert code for Option 1 here
  echo "You have selected Option 1"
}

# Define function for Option 2
function option2 {
  # Insert code for Option 2 here
  echo "You have selected Option 2"
}

# Define function for Option 3
function option3 {
  # Insert code for Option 3 here
  echo "You have selected Option 3"
}

# Call menu function
while true; do
  menu
  case $choice in
    1) option1 ;;
    2) option2 ;;
    3) option3 ;;
    Q|q) break ;;
    *) echo "Invalid option. Press any key to try again."; read -n1 ;;
  esac
done