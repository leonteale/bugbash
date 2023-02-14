read -rp "Enter the name of the client: " client_name

# Check if client name is empty
while [[ -z "$client_name" ]]; do
    echo -e "${RED}Error: Client name cannot be empty.${NC}"
    read -rp "Enter the name of the client: " client_name
done

# Sanitize client name by removing spaces and special characters
client_name=$(echo "$client_name" | tr -dc '[:alnum:]-' | tr '[:upper:]' '[:lower:]')

# Check if client folder already exists
while [[ ! -d "${HOME}/.bugbash/${client_name}" ]]; do

  # Create the directory for the new client name

        echo "Creating directory ${HOME}/.bugbash/${client_name}"
        WD="${HOME}/.bugbash/${client_name}"
        mkdir -p "${HOME}/.bugbash/${client_name}"
        echo "New directory created for ${client_name}"
        read -rp "Do you want to set a target domain? (Y/n) " yn
        case $yn in
            [Yy]* ) source addnewdomain.sh; break;;
            [Nn]* ) break;;
            * ) source addnewdomain.sh; break;;
        esac
        break

    if [[ -f "${HOME}/.bugbash/${client_name}/${client_name}.txt" ]]; then
        Domain=$(cat "${HOME}/.bugbash/${client_name}/${client_name}.txt")
        echo "This customer name already exists and has a domain: $Domain" 
        read -rp "Do you want to pick an existing client folder? (Y/n) " yn
        case $yn in
            [Yy]* ) source load.sh; break;;
            [Nn]* ) read -rp "Enter a NEW name for the client: " client_name;
                    # Create the directory for the new client name
                    echo "Creating directory ${HOME}/.bugbash/${client_name}"
                    WD="${HOME}/.bugbash/${client_name}"
                    Domain=""
                    mkdir -p "${HOME}/.bugbash/${client_name}"
                    echo "New directory created for ${client_name}"
                    break;;
            * ) source load.sh; break;;
        esac
    else
        # Create the directory for the new client name
        echo "else statment"
    fi
done
