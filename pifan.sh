#!/bin/bash

set -e

# Ensure script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

echo "=> Installing dependencies..."
apt update && apt install -y python3 python3-pip

# Clone the repository
cd /opt
git clone https://github.com/Howchoo/pi-fan-controller.git fan-controller
cd fan-controller

echo "=> Setting up fan control script..."
chmod +x fancontrol.py
cp fancontrol.py /usr/local/bin/

echo "=> Setting up fan control service..."
cp fancontrol.sh /etc/init.d/fancontrol
chmod +x /etc/init.d/fancontrol

# Add service to startup
update-rc.d fancontrol defaults

echo "=> Starting fan controller..."
/etc/init.d/fancontrol start

echo "Fan controller installed and running."
