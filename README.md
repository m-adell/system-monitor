# SYSTEM MONITOR DASHBOARD


## About the project

 A simple Bash script that monitors your linux system's CPU, Memory and Disk usage in real-time.
it generates a report and sends alerts when usage exceeds 80% or when disk space almost full.

This is my first real project after learning Linux and Bash scripting as a part of my DevOps journey.

## Features

 **CPU Usage** - Shows current CPU usage percentage
 **Memory Usage** - Show used and free Memory percentage
 **Disk Usage** - Show total, used and free disk space
 **Alerts** - Logs warnings when CPU or Memory exceeds 80% Usage, and when the disk free space goes below 20% with timestamps
 **output Files** - saves reports to 'sysreport.txt' and alerts to 'alerts.log'

## Technologies Used

 **Bash** - Scripting language
 **Linux Commands** - 'top, free, df, awk, grep, date'
 **Cron** - for scheduling automatic runs


## *How to run:*

```bash
git clone https://github.com/m-adell/system-monitor.git
cd system-monitor
chmod +x sysmonitor.sh
./sysmonitor.sh
