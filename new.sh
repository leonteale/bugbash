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
               [Nn]* ) read -rp "Enter a new name for the client: " client_name;
              esac
            fi
          done
