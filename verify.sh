ping -c 4 192.168.1.254 && printf "\n Successfully contacted External Router \n\n" || printf "\n FAILED \n"
ping -c 4 192.168.1.80 && printf "\n Successfully contacted DMZ Server \n\n" || printf "\n FAILED \n"
ping -c 4 192.168.1.1 && printf "\n Successfully contacted Interal Router (2) \n\n" || printf "\n FAILED \n!"
ping -c 4 10.10.1.254 && printf "\n Successfully contacted Internal Router \n\n" || printf "\n FAILED \n!"

curl --max-time 2 https://qut.edu.au && printf "\n Successfully downloaded QUT page \n\n" || printf "\n FAILED \n!"

