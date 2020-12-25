#!/bin/bash
set -e

TYPE=$1
SLB_ID=$2
CERT_ID=$3

NAMESPACE="kube-system"
INGRESS_CLASS="nginx-${TYPE}"
INGRESS_TEMP="ingress-controller-template.yml.j2"
INGRESS_YAML="ingress-controller-${TYPE}.yml"

# Input ingress controller type: inter or intra
if [ ! -n "$TYPE" ] ;then
  echo "Please input inter or intra"
  exit
else
  echo "Your ingress controller type: $TYPE"
fi

# Input ingress controller type: inter or intra
if [ ! -n "$SLB_ID" ] ;then
  echo "Please input alicloud slb id"
  exit
else
  echo "Your slb id: $SLB_ID"
fi

# Input Cert ID 
if [ ! -n "$CERT_ID" ] ;then
  echo "Please input cert id"
  exit
else
  echo "Your cert id:  $CERT_ID"
fi

# Determine whether the jinja2 command exists 
if command -v jinja2 >/dev/null 2>&1; then 
  : 
else 
  echo 'jinja2 not exists,please install it!'
  exit 
fi

# start work
jinja2 -D Namespace=${NAMESPACE} -D LoadbalancerID=${SLB_ID} -D CertID=${CERT_ID} -D IngressClass=${INGRESS_CLASS} ${INGRESS_TEMP} > ${INGRESS_YAML} 

sed -i "" "s/ nginx-ingress-controller/ nginx-ingress-controller-${TYPE}/g" ${INGRESS_YAML}
sed -i "" "s/nginx-ingress-lb/nginx-ingress-lb-${TYPE}/g" ${INGRESS_YAML}
sed -i "" "s/ tcp-services/ tcp-services-${TYPE}/g" ${INGRESS_YAML}
sed -i "" "s/\/tcp-services/\/tcp-services-${TYPE}/g" ${INGRESS_YAML}
sed -i "" "s/ udp-services/ udp-services-${TYPE}/g" ${INGRESS_YAML}
sed -i "" "s/\/udp-services/\/udp-services-${TYPE}/g" ${INGRESS_YAML}
sed -i "" "s/ ingress-nginx/ ingress-nginx-${TYPE}/g" ${INGRESS_YAML}
sed -i "" "s/ nginx-configuration/ nginx-configuration-${TYPE}/g" ${INGRESS_YAML}

echo "Convert complete!"
