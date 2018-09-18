ping -c 4 192.168.1.254 && printf '\n Successfully contacted External Router \n\n' || printf 'FAILED!'
ping -c 4 192.168.1.80 && printf '\n Successfully contacted DMZ Server \n\n' || printf 'FAILED!'
ping -c 4 192.168.1.1 && printf '\n Successfully contacted Internal Router (2) \n\n' || printf 'FAILED!'
ping -c 4 10.10.1.254 && printf '\n Successfully contacted Interal Router \n\n' || printf 'FAILED!'
ping -c 4 10.10.1.1 && printf '\n Successfully contacted Interal Host \n\n' || printf 'FAILED!'

