#!/usr/bin/env bash
set -e

# Domain
DOMAIN="cfapps.io"
if [ ! -z "$1" ]; then
  DOMAIN=$1;
fi
echo "=====> Using domain: ${DOMAIN}"

echo "=====> ./mvnw package"
./mvnw package

echo "=====> cf push -f attendee/manifest.yml"
cf push -f attendee/manifest.yml

echo "=====> cf push -f articulate/manifest.yml"
cf push -f articulate/manifest.yml

echo "=====> cf cups pcf101-demo-attendee-service -p uri https://pcf101-demo-attendee.${DOMAIN}/attendees"
cf cups pcf101-demo-attendee-service -p "{\"uri\":\"https://pcf101-demo-attendee.${DOMAIN}/attendees\"}"

echo "=====> cf cf bind-service pcf101-demo-articulate pcf101-demo-attendee-service"
cf bind-service pcf101-demo-articulate pcf101-demo-attendee-service

echo "=====> cf restage pcf101-demo-articulate"
cf restage pcf101-demo-articulate

open "https://pcf101-demo-articulate.${DOMAIN}"