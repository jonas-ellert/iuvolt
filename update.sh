#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Copying iuvolt script to /usr/bin/..."
cp iuvolt /usr/bin/
chmod +x /usr/bin/iuvolt
status=disabled

if [ -f /etc/systemd/system/iuvolt.service ]; then
    echo "Uninstalling old service (Status: $status)..."
	status=$(systemctl is-enabled iuvolt.service)
	systemctl stop iuvolt.service
	systemctl disable iuvolt.service
	rm /etc/systemd/system/iuvolt.service
fi

echo "Installing new service..."
cp iuvolt.service /etc/systemd/system/
systemctl daemon-reload

if [ "$status" = "enabled" ]; then
    echo "Enabling new service..."
	systemctl enable iuvolt.service
fi

echo "Starting new service..."
systemctl restart iuvolt.service
