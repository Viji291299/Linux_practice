#!/bin/bash 
#log cleanup.sh 
################


set -eu 

LOG="/home/viji/devops/linuxops/logs/cleanup.txt"
TARGET_DIR="${1:-/home/viji/devops/linuxops/cleanup}"
DAYS="${2:-7}"

log()
{
echo "$(date '+%F %T') [$1] $2" | tee -a "$LOG"
}

if [ ! -d "$TARGET_DIR" ] ; then 
 log ERROR "Target Directory is wrong"
 exit 1
fi 
 
COUNT=$(find "$TARGET_DIR" -type f -name "*.log" -mtime +"$DAYS" | wc -l)
 
find "$TARGET_DIR" -type f -name "*.log" -mtime +"$DAYS" -delete
 log INFO "Total Logs cleaned up : $COUNT" 
 exit 0
 

