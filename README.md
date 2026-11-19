# LinuxOps Toolkit
## Overview
This is a toolkit that will analyse disk space, clear logs , check CPu status and memory and manage users and groups 
## Folder structure
contains three folder 
1)scripts
user management 
group managemnt 
disk_space 
log_cleanup
health_check 
2)logs
all logs of the scripst 
3)config 
 cron job 
 logrotate
## Setup
## Setup
```bash
git clone https://github.com/Viji291299/Linux_practice.git
cd Linux_practice
chmod +x scripts/*.sh
crontab config/linuxops.cron
sudo cp config/linuxops.logrotate /etc/logrotate.d/linuxops
sudo logrotate -d /etc/logrotate.d/linuxops   # dry run to verify
```
Requires: Bash, cron (`systemctl is-active cron`), logrotate.
Edit paths in scripts and the cron file if you cloned somewhere other than /home/viji/devops/linuxops.
## Scripts 
| Script | Purpose | Usage |
|---|---|---|
| user_mgmt.sh | Create a user and add them to a group | sudo ./scripts/user_mgmt.sh alice devteam |
| disk_monitor.sh | Warn when disk usage passes a threshold (default 80%) | ./scripts/disk_monitor.sh [threshold] |
| log_cleanup.sh | Delete .log files older than N days (default 7) | ./scripts/log_Cleanup.sh [dir] [days] |
| health_check.sh | Log load, memory, disk, top processes and check a service (default cron) | ./scripts/health_check.sh [service] |
## Scheduling (cron)
for every week log cleanup is scheduled and for every 5 mins health check will be performed and for every 15 minutes disk space alert will be given which is traced on logs
## Logs and rotation
logs are updated for every incident and those would be compressed and archived using logrotate function 
## Troubleshooting
Check for permission issues and fix it by enabling permissions 
for cleanup add dummy files and make it as 10 days old file. threshold is default given as 80 


