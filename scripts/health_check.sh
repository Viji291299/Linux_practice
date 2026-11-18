#!/bin/bash
#healthcheck.sh
########

set -eu

LOG="/home/viji/devops/linuxops/logs/health_check.txt"

log()
{
echo "$(date '+%F %T') [$1] $2" |tee -a "$LOG"
}

LOAD="$(uptime | awk -F "load average:" '{print $2}')"
MEM="$(free -m | awk '/Mem:/ {printf "%.0f\n", $3/$2*100}')"
DISK="$(df / | tail -1 | awk '{print $5}' | tr -d '%')"
TOP="$(ps -eo pid,comm,%cpu --sort=-%cpu | head -4)"

log INFO "memory used :${MEM}%"
log INFO "Load used :${LOAD}"
log INFO "Disk used :${DISK}%"
echo "$TOP" | tee -a "$LOG"

SERVICE="${1:-cron}"

if ! systemctl  is-active --quiet "$SERVICE" ; then 
 log ERROR "$SERVICE  is not active"
 exit 1
else 
 log INFO "$SERVICE is active"
 exit 0
fi



