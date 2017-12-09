#!/usr/bin/env bash
set -e

# Domain
DOMAIN="cfapps.io"
if [ ! -z "$1" ]; then
  DOMAIN=$1;
fi
echo "=====> Using domain: ${DOMAIN}"

# cf push but no route is assigned
echo "=====> cf push -f articulate/manifest-v2.yml --no-route"
cf push -f articulate/manifest-v2.yml --no-route

# Map the existing route to new app
echo "=====> cf map-route pcf101-demo-articulate-v2 ${DOMAIN} -n pcf101-demo-articulate"
cf map-route pcf101-demo-articulate-v2 ${DOMAIN} -n pcf101-demo-articulate

# Scale accordingly
echo "=====> cf push -f articulate/manifest-v2.yml --no-start"
cf scale pcf101-demo-articulate -i 1
cf scale pcf101-demo-articulate-v2 -i 3

# Unmap route for old app
echo "=====> cf push -f articulate/manifest-v2.yml --no-start"
cf unmap-route pcf101-demo-articulate ${DOMAIN} -n pcf101-demo-articulate

# Eventually we can clean up
echo "cf delete pcf101-demo-articulate -f"
cf delete pcf101-demo-articulate -f
echo "cf rename pcf101-demo-articulate-v2 pcf101-demo-articulate"
cf rename pcf101-demo-articulate-v2 pcf101-demo-articulate