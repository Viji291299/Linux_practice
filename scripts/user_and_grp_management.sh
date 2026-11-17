#!/bin/bash
##########
#USER_MANAGEMENT.sh
#########

set -u
LOG="/home/viji/devops/linuxops/logs/user_and_grp_management.log"

log()
{

echo "$(date '+%F%T') [$1] $2" | tee -a "$LOG"
}

if [ "$EUID" -ne 0 ] ; then
	log ERROR "Use ROOT permission"
	exit 1 
fi

USERNAME="${1:-}"
GROUP="${2:-}"

if [ -z "$USERNAME" ] || [ -z "$GROUP" ] ; then 
	log ERROR "Usage:$0 <username> <groupname>"
	exit 1
fi

if id "$USERNAME" &>/dev/null ; then
 log WARN "Username Already Exists" 
 exit 0
fi

if ! getent group "$GROUP" &>/dev/null ; then 
   groupadd "$GROUP"
   log INFO "Group created Successfully"
fi 
  
if useradd -m -s /bin/bash  -G "$GROUP" "$USERNAME" ; then 
  log INFO "User $USERNAME" created  and added to the  group "$GROUP"
 
else
  log ERROR "User  and group creation failed"
  exit 1
 
fi 


	
