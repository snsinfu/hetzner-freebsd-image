#!/bin/sh
set -u

# https://docs.openstack.org/nova/rocky/user/metadata-service.html
API="http://169.254.169.254/2009-04-04"

# Set hostname.
sysrc hostname="$(fetch -o- "${API}/meta-data/hostname")"
service hostname restart

# Run user script if provided.
fetch -o- "${API}/user-data" | sh
