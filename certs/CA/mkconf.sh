#!/bin/sh
sslConfPlace=$(openssl version -a | grep OPENSSLDIR | awk '{print $2}' | xargs)
cat <<EOF
$(cat $sslConfPlace"/openssl.cnf")

[SAN]
subjectAltName=DNS:$1,DNS:*.$1
EOF
