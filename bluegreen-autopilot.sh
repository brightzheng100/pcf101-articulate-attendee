#!/usr/bin/env bash
set -e

# Domain
DOMAIN="cfapps.io"
if [ ! -z "$1" ]; then
  DOMAIN=$1;
fi
echo "=====> Using domain: ${DOMAIN}"

# Make sure you have installed Autopilot CF plugin
cf zero-downtime-push pcf101-demo-articulate -f articulate/manifest-autopilot.yml
