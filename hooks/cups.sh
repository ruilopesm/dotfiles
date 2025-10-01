#!/bin/sh

sudo systemctl enable --now cups.service
sudo usermod -aG cups $USER
sudo tee /etc/papersize > /dev/null << 'EOF'
A4
EOF
