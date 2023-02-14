# check if subtake is installed
if ! which subtake >/dev/null 2>&1; then
  echo "subtake not found, installing..."
  #sudo apt-get -y install subfinder
fi

# check if subtake is installed and run it
if which subtake >/dev/null 2>&1; then
  echo "Running subtakeagainst $num_subdomains subdomains"
  
  subtake -f "${WD}/subdomains.${Domain}.txt" -ssl -a -o "${WD}/subtake.${Domain}.txt" -c ~/go/src/github.com/jakejarvis/subtake/fingerprints.json -v

  if [[ -f "${WD}/subtake.${Domain}.txt" ]]; then
    num_subtake=$(cat "${WD}/subtake.${Domain}.txt" | grep -vE 'Not Vulnerable'| sort -u | wc -l )
    echo "$num_subtake - Vulnerable subdomains found"
    cat ${WD}/subtake.${Domain}.txt | grep -vE 'Not Vulnerable' > ${WD}/vulnerable.subtake.${Domain}.txt
    cat ${WD}/vulnerable.subtake.${Domain}.txt
  else
    echo "No vulnerable subdomains found"
  fi

else
  echo "subtake not found, please install it manually."
fi