#!/bin/bash
set -e

TYPE=$1

INGRESS_TEMP="ingress-alibaba-log-template.yml.j2"
INGRESS_YAML="ingress-alibaba-log-${TYPE}.yml"

# Input ingress controller type: inter or intra
if [ ! -n "$TYPE" ] ;then
  echo "Please input inter or intra"
  exit
else
  echo "Your ingress controller type: $TYPE"
fi

# Determine whether the jinja2 command exists
if command -v jinja2 >/dev/null 2>&1; then
  :
else
  echo 'jinja2 not exists,please install it!'
  exit
fi

# start work
jinja2 -D Type=${TYPE} ${INGRESS_TEMP} > ${INGRESS_YAML} 

echo "Convert complete!"
