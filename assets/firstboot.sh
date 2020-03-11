#!/bin/sh
set -u

# Set hostname.
sysrc hostname="$(fetch -o- http://169.254.169.254/latest/meta-data/hostname)"
service hostname restart

# User script
fetch -o- http://169.254.169.254/latest/user-data | sh
