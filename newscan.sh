# Check if user wants to add to an existing client or create a new one
read -rp "Do you want to add to an existing client or create a new one? (E/N) " choice

case $choice in
  [Ee]* ) # List existing client folders
          echo -e "${GREEN}Existing clients:${NC}"
          client_folders=($(find "${HOME}/.bugbash" -maxdepth 1 -mindepth 1 -type d -printf "%f\n"))
          for i in "${!client_folders[@]}"; do
            printf "%s) %s\n" "$((i+1))" "${client_folders[$i]}"
          done

          # Select client to add to
          read -rp "Enter the number of the client to add to: " choice
          while [[ ! "$choice" =~ ^[1-9][0-9]*$ ]] || ((choice > ${#client_folders[@]})); do
            echo -e "${RED}Invalid choice.${NC}"
            read -rp "Enter the number of the client to add to: " choice
          done

          client_name=${client_folders[$((choice-1))]}
          WD="${HOME}/.bugbash/${client_name}"
          echo -e "${GREEN}Working directory set to ${HOME}/.bugbash/${client_name}.${NC}"
          ;;
  * )     # Create new client
          read -rp "Enter the name of the client: " client_name

          # Check if client name is empty
          while [[ -z "$client_name" ]]; do
            echo -e "${RED}Error: Client name cannot be empty.${NC}"
            read -rp "Enter the name of the client: " client_name
          done

          # Remove any spaces or special characters from client name
          client_name=$(echo "$client_name" | tr -dc '[:alnum:]\n\r')

          # Check if client folder already exists
          while [[ -d "${HOME}/.bugbash/${client_name}" ]]; do
            if [[ -f "${HOME}/.bugbash/${client_name}/${client_name}.txt" ]]; then
              read -rp "Domain file already exists. Do you want to keep this domain? (Y/N) " yn
              case $yn in
                [Yy]* ) Domain=$(cat "${HOME}/.bugbash/${client_name}/${client_name}.txt"); break;;
                [Nn]* ) read -rp "Enter a new domain name: " Domain; break;;
                * ) echo -e "${RED}Please answer Y or N.${NC}";;
              esac
            else
              read -rp "Folder already exists. Do you want to use this folder? (Y/N) " yn
              case $yn in
                [Yy]* ) WD="${HOME}/.bugbash/${client_name}"; echo -e "${GREEN}Working directory set to ${HOME}/.bugbash/${client_name}.${NC}"; break;;
[Nn]* ) read -rp "Enter a new name for the client: " client_name;;
* ) echo -e "${RED}Please answer Y or N.${NC}";;
esac
# Remove any spaces or special characters from client name
client_name=$(echo "$client_name" | tr -dc '[:alnum:]\n\r')
fi
done

      # Create folder for client in user's home directory
      mkdir -p "${HOME}/.bugbash/${client_name}"

echo -e "${GREEN}Client folder created successfully.${NC}"
#Set client name as working directory

WD="${HOME}/.bugbash/${client_name}"
;;

esac

#Ask for domain name and sanitize input

if [[ -z "$Domain" ]]; then
read -rp "Enter a domain name: " Domain
Domain=$(echo "$Domain" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')

#Sanitize input to ensure only valid domain is entered
while ! [[ "$Domain" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]{1,61}[a-zA-Z0-9]$ ]]; do
echo -e "${RED}Invalid domain name.${NC}"
read -rp "Enter a valid domain name: " Domain
Domain=$(echo "$Domain" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')
done
fi

#Check if domain file already exists

if [[ -f "${WD}/${client_name}.txt" ]]; then
read -rp "Domain file already exists. Do you want to keep this domain? (Y/N) " yn
case $yn in
[Yy]* ) echo -e "${GREEN}Domain not changed.${NC}";;
[Nn]* ) 
  while true; do
    read -rp "Enter a new domain name: " Domain
    if [[ ! -f "${WD}/${client_name}.txt" ]]; then
      break
    fi
    echo -e "${RED}A domain file with this name already exists. Please enter a different name.${NC}"
  done
  ;;
* ) echo -e "${RED}Please answer Y or N.${NC}";;
esac
fi
#Save domain to file
echo "$Domain" > "${WD}/${client_name}.txt"
echo -e "${GREEN}Domain ${Domain} saved to ${WD}/${client_name}.txt.${NC}"
read -n1 -r -p "Press any key to continue..."
