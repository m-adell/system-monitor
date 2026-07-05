#!/bin/bash

# alerting variables
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_MIN_FREE=20
REPORT_LOG="$HOME/sysreport.txt"
ALERT_LOG="$HOME/alert.log"
timestamp=$(date "+%Y-%m-%d %H:%M:%S %a")

# CPU Usage
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print int(100 - $8)}')

# Memory Usage
read USED_MEM_PERCENT FREE_MEM_PERCENT <<< $(free | grep Mem | awk '{print int($3/$2*100),int($4/$2*100)}')
TOTAL_MEM=$(free -h |grep Mem |awk '{print $2}')

# Disk Usage
read TOTAL_DISK USED_DISK FREE_DISK_PERCENT <<< $(df -h | grep "^/" | awk '{print $2,$3,100 - $5 }')


echo " 'SYSTEM MONITOR - $timestamp'

CPU Usage| [${cpu}% Used]

Mem Usage| [Total:$TOTAL_MEM Used:${USED_MEM_PERCENT}% Free:${FREE_MEM_PERCENT}%]

disk info| [Total:$TOTAL_DISK Used:$USED_DISK Free:${FREE_DISK_PERCENT}%]
---------------------" >> $REPORT_LOG

## alerts

if [[ $cpu -gt ${CPU_THRESHOLD} ]]; then
        echo " WARNING - CPU Usage over 80% [${cpu}% used] - $timestamp " >> $ALERT_LOG

fi


if [[ $USED_MEM_PERCENT -gt ${CPU_THRESHOLD} ]]; then
        echo " WARNING - Mem Usage over 80% [${USED_MEM_PERCENT}% used] - $timestamp " >> $ALERT_LOG
if [[ $USED_MEM_PERCENT -gt ${MEM_THERSHOLD} ]]; then
        echo " WARNING - Mem Usage over 80% [${USED_MEM_PERCENT}% used] - $timestamp " >> $ALERT_LOG

fi

if [[ $FREE_DISK_PERCENT -lt ${DISK_MIN_FREE} ]]; then
        echo " WARNING - Disk is almost full [${FREE_DISK_PERCENT}% free] - $timestamp " >> $ALERT_LOG
fi
