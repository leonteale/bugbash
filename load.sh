# List existing client folders
          echo -e "${GREEN}Existing clients:${NC}"
          client_folders=($(find "${HOME}/.bugbash" -maxdepth 1 -mindepth 1 -type d -printf "%f\n"))
          for i in "${!client_folders[@]}"; do
            printf "%s) %s\n" "$((i+1))" "${client_folders[$i]}"
          done

          # Select client to add to
          read -rp "Enter the number of the client to load: " choice
          while [[ ! "$choice" =~ ^[1-9][0-9]*$ ]] || ((choice > ${#client_folders[@]})); do
            echo -e "${RED}Invalid choice.${NC}"
            read -rp "Enter the number of the client to load: " choice
          done

          client_name=${client_folders[$((choice-1))]}
          WD="${HOME}/.bugbash/${client_name}"
          echo -e "${GREEN}Working directory set to ${HOME}/.bugbash/${client_name}.${NC}"