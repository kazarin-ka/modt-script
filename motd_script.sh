#!/bin/sh
# get the load averages
read one five fifteen rest < /proc/loadavg
echo "$(tput setaf 2)
$(figlet Welcome to:)
$(figlet $(hostname))
$(date +"%A, %e %B %Y, %r")
$(uname -srmo)
$(tput setaf 3)
Uptime........................: $(uptime -p)
Memory........................: $(free -h | grep Mem | awk '{print  $4" (Free) / " $3" (Used) / " $2 " (Total)"}')
Load Averages.................: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
Running Processes.............: $(ps ax | wc -l | tr -d " ")
Zombie Processes..............: $(($(ps aux | grep 'Z' | wc -l) - 2 ))
IP Addresses..................: $(ip a | grep glo | awk '{print $2}' | head -1 | cut -f1 -d/) and $(wget -q -O - http://icanhazip.com/ | tail)
Last Login....................: $(last | head -n 2 | tail -n 1 | awk '{print $1" " $5" "$6" "$7}')
$(tput sgr0)"
for DISK in $(fdisk -l |grep -oP "sd[a-z]" | uniq)
do
    echo "$(tput setaf 3)
Disk $DISK Used Space...........: $(df -h | grep $DISK | awk '{print $5}')
    $(tput sgr0)"
done