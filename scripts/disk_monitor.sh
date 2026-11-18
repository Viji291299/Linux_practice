#!/bin/bash
#disk monitor.sh
###########

set -eu

LOG="/home/viji/devops/linuxops/logs/disk_monitor.log"

log()
{
echo "$(date '+%F %T') [$1] $2" | tee -a "$LOG"

}

USAGE="$(df -h / | tail -1 | awk '{print $5}' |tr -d '%')"
THRESHOLD="${1:-80}"

if [ -z "$USAGE" ] ; then 
 log ERROR "Could not read disk usage"
 exit 1
fi



if [ "$USAGE" -ge "$THRESHOLD" ] ; then 
 log WARN "Disk Space Exceeds the threshold ${USAGE}%"
 exit 1
fi

 log INFO "Disk Space within the threshold"
 exit 1 

