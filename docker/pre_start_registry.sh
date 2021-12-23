#!/bin/bash

mkdir /auth ; cd /auth

docker run --rm -v /auth:/auth alpine/openssl \
req -newkey rsa:4096 -nodes -sha256 -x509 \
-days 365 -keyout /auth/myregistry.com.key -out /auth/myregistry.com.crt \
-subj '/CN=myregistry.com' \
-addext "subjectAltName = DNS:myregistry.com"

# create htpasswd file
docker run --rm --entrypoint htpasswd httpd:2.4 -Bbn demouser password > /auth/htpasswd

# client certification
mkdir -p /etc/docker/certs.d/myregistry.com
cp /auth/myregistry.com.crt /etc/docker/certs.d/myregistry.com/ca.crt

