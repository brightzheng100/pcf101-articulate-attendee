#!/usr/bin/env bash
set -e

get_code="curl -I ${app_url} 2>/dev/null | head -n 1 | cut -d$' ' -f2"
status_code=`eval $get_code`
echo "The status code returned is: $status_code"

if [ "$status_code" != "200" ]
then
  echo "Expected status code from ${app_url} is 200, but got $status_code"
  exit 1
fi
