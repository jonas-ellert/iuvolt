#!/bin/bash
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
systemctl disable iuvolt.service
rm /etc/systemd/system/iuvolt.service
rm /usr/bin/iuvolt

#Legacy
rm /usr/lib/systemd/system-sleep/iuvolt

echo 'Done.'
