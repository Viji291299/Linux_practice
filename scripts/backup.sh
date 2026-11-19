#!/bin/bash
############
#backup.sh -- taking backup 
#############

set -eu

SRC="${1:-/home/viji/devops/linuxops/scripts}"
LOG=/home/viji/devops/linuxops/logs/backup_logs.txt
DEST_DIR=/home/viji/tmp/backups

mkdir -p "$DEST_DIR"

log()
{
echo "$(date '+%F %T') [$1] $2 "| tee -a "$LOG"
}

if [ ! -d "$SRC" ] ; then 
  log ERROR "$SRC does not exist" 
  exit 1
fi 
DEST="$DEST_DIR/backup_$(date '+%F_%H%M%S').tar.gz"

if tar -czf "$DEST" "$SRC" ; then 
 log INFO "Backup completed "
 exit 0
else 
 log ERROR "Backup failed for $SRC"
 exit 1 
fi 

