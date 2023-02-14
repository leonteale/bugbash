          # Check if client folder already exists
          # while [[ -d "${HOME}/.bugbash/${client_name}" ]]; do

            if [[ -f "${HOME}/.bugbash/${client_name}/${client_name}.txt" ]]; then
              read -rp "Are you sure you want to update the current domain? (y/n)" yn
              case $yn in
                [Nn]* ) Domain=$(cat "${HOME}/.bugbash/${client_name}/${client_name}.txt");break;;
                [Yy]* ) read -rp "Enter a new domain name: " Domain; echo $Domain > ${HOME}/.bugbash/${client_name}/${client_name}.txt ; break;;
                * ) echo -e "${RED}Please answer Y or N.${NC}";;
              esac


            else
              read -rp "Enter a target domain: " Domain; echo $Domain > ${HOME}/.bugbash/${client_name}/${client_name}.txt
            fi
          # done