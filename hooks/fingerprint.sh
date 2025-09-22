#!/bin/sh

sudo tee /etc/pam.d/polkit-1 > dev/null << 'EOF'
#%PAM-1.0

auth       sufficient   pam_fprintd.so
auth       required     pam_unix.so

account    required     pam_unix.so
password   required     pam_unix.so
session    required      pam_unix.so
EOF
