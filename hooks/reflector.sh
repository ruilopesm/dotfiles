#!/bin/sh

sudo reflector --country Portugal --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
