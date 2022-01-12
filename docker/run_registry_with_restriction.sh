#!/bin/bash

docker run -d -p 443:443 --restart=always --name registry \
-v /auth:/certs \
-v /image-vol:/var/lib/registry \
-e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/myregistry.com.crt \
-e REGISTRY_HTTP_TLS_KEY=/certs/myregistry.com.key \
-e "REGISTRY_AUTH=htpasswd" \
-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
-e REGISTRY_AUTH_HTPASSWD_PATH=/certs/htpasswd \
registry
