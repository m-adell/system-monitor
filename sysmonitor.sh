#!/bin/bash

# CPU Usage
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print int(100 - $8)}')

# Memory Usage
read USED_MEM_PERCENT FREE_MEM_PERCENT <<< $(free | grep Mem | awk '{print int($3/$2*100),int($4/$2*100)}')
TOTAL_MEM=$(free -h |grep Mem |awk '{print $2}')

# Disk Usage
read TOTAL_DISK USED_DISK FREE_DISK_PERCENT <<< $(df -h | grep "^/" | awk '{print $2,$3,100 - $5 }')


echo " 'SYSTEM MONITOR - $(date +"%Y-%m-%d %H:%M:%S | %a")'

CPU Usage| $cpu% Used

Mem Usage| Total:$TOTAL_MEM Used:$USED_MEM_PERCENT% Free:$FREE_MEM_PERCENT%

disk info| Total:$TOTAL_DISK Used:$USED_DISK Free:$FREE_DISK_PERCENT%
---------------------" >> ~/sysreport.txt

## alerts

if [[ $cpu -gt 80 ]]; then
        echo " WARNING - Cpu Usage over 80% $CPU% used - $(date +"%Y-%m-%d %H:%M:%S | %a") " >> ~/alert.log

fi

if [[ $USED_MEM_PERCENT -gt 80 ]]; then
        echo " WARNING - Mem Usage over 80% $USED_MEM_PERCENTAGE% used - $(date +"%Y-%m-%d %H:%M:%S | %a") " >> ~/alert.log
fi

if [[ $FREE_DISK_PERCENT -lt 20 ]]; then
        echo " WARNING - Disk is almost full $FREE_DISK_PERCENT% free - $(date +"%Y-%m-%d %H:%M:%S | %a") " >> ~/alert.log
fi
