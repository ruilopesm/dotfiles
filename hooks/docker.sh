#!/bin/sh
set -e

sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"
