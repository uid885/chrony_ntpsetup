#!/bin/bash
# Author         : Christo Deale
# Date	         : 2024-04-02
# chrony_ntpsetup: Utility to setup Chrony as NTP server

# Install Chrony
sudo yum install -y chrony

# Configure Chrony
sudo sed -i '/^allow/c\allow 192.168.0.0/24' /etc/chrony.conf
sudo tee -a /etc/chrony.conf > /dev/null <<EOT
server 0.centos.pool.ntp.org
server 1.centos.pool.ntp.org
server 2.centos.pool.ntp.org
EOT

# Start and Enable Chrony service
sudo systemctl start chronyd
sudo systemctl enable chronyd

# Allow Chrony service through firewall
sudo firewall-cmd --add-service=ntp --permanent
sudo firewall-cmd --reload

# Verify Chrony synchronization
chronyc sources
