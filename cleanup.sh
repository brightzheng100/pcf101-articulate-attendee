#!/usr/bin/env bash
set -e

cf delete pcf101-demo-articulate -f -r
cf delete pcf101-demo-attendee -f -r
cf delete-service pcf101-demo-attendee-service -f