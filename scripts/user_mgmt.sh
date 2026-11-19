#!/bin/bash
##########
#USER_MANAGEMENT.sh
#########

set -u
LOG="/home/viji/devops/linuxops/logs/usermanagement.log"

log()
{

echo "$(date '+%F%T') [$1] $2" | tee -a "$LOG"
}

if [ "$EUID" -ne 0 ] ; then
	log ERROR "Use ROOT permission"
	exit 1 
fi

USERNAME="${1:-}"

if [ -z "$USERNAME" ] ; then 
	log ERROR "Usage:$0 <username>"
	exit 1
fi

if id "$USERNAME" &>/dev/null ; then
 log WARN "Username Already Exists" 
 exit 0
fi

if useradd -m -s /bin/bash "$USERNAME" ; then 
  log INFO "User created $USERNAME"
 
else
  log ERROR "User creation failed"
  exit 1
 
fi 



	
