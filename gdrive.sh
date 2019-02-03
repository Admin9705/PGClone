#!/bin/bash
#
# Title:      PGClone (A 100% PG Product)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pgclone/functions/functions.sh
source /opt/pgclone/functions/keys.sh
source /opt/pgclone/functions/keyback.sh
source /opt/pgclone/functions/pgclone.sh
################################################################################

################################ Forces RClone Installer ######## START
echo "14" > ${abc}/pg.rcloneprime

core () {
    touch /var/plexguide/pg."${1}".stored
    start=$(cat /var/plexguide/pg."${1}")
    stored=$(cat /var/plexguide/pg."${1}".stored)
    if [ "$start" != "$stored" ]; then
      $1
      cat /var/plexguide/pg."${1}" > /var/plexguide/pg."${1}".stored;
    fi
}

rcloneprime () {
  ansible-playbook /opt/pgclone/pg.yml --tags rcloneinstall

tee "/etc/fuse.conf" > /dev/null <<EOF
# /etc/fuse.conf - Configuration file for Filesystem in Userspace (FUSE)
# Set the maximum number of FUSE mounts allowed to non-root users.
# The default is 1000.
#mount_max = 1000
# Allow non-root users to specify the allow_other or allow_root mount options.
user_allow_other
EOF

}

core rcloneprime
################################ Forces RClone Installer ######## END

question1 () {
  touch /opt/appdata/plexguide/rclone.conf
  transport=$(cat /var/plexguide/pgclone.transport)
  gstatus=$(cat /var/plexguide/gdrive.pgclone)
  tstatus=$(cat /var/plexguide/tdrive.pgclone)
  transportdisplay
  mkdir -p /opt/appdata/pgblitz/keys/processed/
  keynum=$(ls /opt/appdata/pgblitz/keys/processed/ | wc -l)
  bwdisplay=$(cat /var/plexguide/move.bw)
  bwdisplay2=$(cat /var/plexguide/blitz.bw)
  file="/var/plexguide/rclone/deploy.version"
    if [ ! -e "$file" ]; then echo "null" > /var/plexguide/project.final; fi

if [ "$transport" == "NOT-SET" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone                 📓 Reference: pgclone.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Data Transport Mode: $transport
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type Selection | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then
  transportmode
  question1
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then exit; fi
fi

if [[ "$transport" == "PG Blitz /w No Encryption" || "$transport" == "PG Blitz /w Encryption" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone                 📓 Reference: pgclone.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Data Transport Mode: $transport
[2] OAuth & Mounts
[3] Key Management:      $keynum Keys Deployed
[4] Throttle Limit:      $bwdisplay2 MB
[5] Deploy:              $transport
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type Selection | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then
transportmode
question1
elif [ "$typed" == "2" ]; then
mountsmenu
question1
elif [ "$typed" == "3" ]; then
keymenu
question1
elif [ "$typed" == "4" ]; then
bandwidthblitz
question1
elif [ "$typed" == "5" ]; then
    if [ "$transport" == "PG Blitz /w No Encryption" ]; then
      removepgservices
      deploygdrivecheck
      deploytdrivecheck
      deploygdsa01check
      ufsbuilder
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/tdrive.yml
      ansible-playbook /opt/pgclone/pgunion.yml
      pgbdeploy
      question1
    elif [ "$transport" == "PG Blitz /w Encryption" ]; then
      removepgservices
      deploygdrivecheck
      deploytdrivecheck
      deploygdsa01check
      ufsbuilder
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/tdrive.yml
      ansible-playbook /opt/pgclone/gcrypt.yml
      ansible-playbook /opt/pgclone/tcrypt.yml
      ansible-playbook /opt/pgclone/pgunion.yml
      pgbdeploy
      question1
    fi
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
  exit
else
  badinput
  question1; fi
fi

if [[ "$transport" == "PG Move /w No Encryption" || "$transport" == "PG Move /w Encryption" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Welcome to PG Clone                 📓 Reference: pgclone.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Data Transport Mode: $transport
[2] OAuth & Mounts
[3] Throttle Limit:      $bwdisplay MB
[4] Deploy:              $transport
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Type Selection | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then
transportmode
question1
elif [ "$typed" == "2" ]; then
mountsmenu
question1
elif [ "$typed" == "3" ]; then
bandwidth
question1
elif [ "$typed" == "4" ]; then
    if [ "$transport" == "PG Move /w No Encryption" ]; then
      mkdir -p /var/plexguide/rclone/
      echo "gdrive" > /var/plexguide/rclone/deploy.version
      removepgservices
      deploygdrivecheck
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/pgunion.yml
      question1
    elif [ "$transport" == "PG Move /w Encryption" ]; then
      mkdir -p /var/plexguide/rclone/
      removepgservices
      deploygdrivecheck
      deploygcryptcheck
      ansible-playbook /opt/pgclone/gdrive.yml
      ansible-playbook /opt/pgclone/gcrypt.yml
      ansible-playbook /opt/pgclone/pgunion.yml
      question1
    fi
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
  exit
else
  badinput
  question1; fi
fi

inputphase
}

mkdir -p /var/plexguide/rclone
# Reminder for gdrive/tdrive / check rclone to set if active, below just placeholder
variable /var/plexguide/project.account "NOT-SET"
variable /var/plexguide/pgclone.project "NOT-SET"
variable /var/plexguide/pgclone.teamdrive ""
variable /var/plexguide/pgclone.public ""
variable /var/plexguide/pgclone.secret ""
variable /var/plexguide/rclone/deploy.version "null"
variable /var/plexguide/pgclone.transport "PG Move /w No Encryption"
variable /var/plexguide/gdrive.pgclone "⚠️  Not Activated"
variable /var/plexguide/tdrive.pgclone "⚠️  Not Activated"
variable /var/plexguide/move.bw  "9"
variable /var/plexguide/blitz.bw  "1000"
variable /var/plexguide/pgclone.password ""
variable /var/plexguide/pgclone.salt ""

question1
