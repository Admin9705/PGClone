#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
transportselect () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💪 Set PG Clone Method ~ http://pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: Please visit the link and understand what your doing first!

[1] Move  Unencrypt: Data > GDrive | Easy    | 750GB Daily Transfer Max
[2] Move  Encrypted: Data > GDrive | Easy    | 750GB Daily Transfer Max
[3] Blitz Unencrypt: Data > TDrive | Complex | Exceed 750GB Transport Cap
[4] Blitz Encrypted: Data > TDrive | Complex | Exceed 750GB Transport Cap
[5] PGDrive Mode   : Read Only     | Novice  | No Upload Data Transfer
[6] Local Edition  : Local HDs     | Simple  | No GDrive/TDrive Usage
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
    echo "mu" > /var/plexguide/pgclone.transport ;;
    2 )
    echo "me" > /var/plexguide/pgclone.transport ;;
    3 )
    echo "bu" > /var/plexguide/pgclone.transport ;;
    4 )
    echo "be" > /var/plexguide/pgclone.transport ;;
    5 )
    echo "pd" > /var/plexguide/pgclone.transport ;;
    6 )
    echo "le" > /var/plexguide/pgclone.transport ;;
    z )
        mustset ;;
    Z )
        mustset ;;
    * )
        mustset ;;
esac
}
