#!/bin/sh

cat <<EOF
[req]
default_bits       = 2048
distinguished_name = req_distinguished_name
req_extensions     = req_ext

[req_distinguished_name]
countryName                 = $2
stateOrProvinceName         = $3
organizationName           = $4
commonName                 = $1

[req_ext]
subjectAltName = @alt_names
[alt_names]
DNS.1   = $1
DNS.2   = *.$1
DNS.3   = *.test.$1
DNS.4   = *.dc01.$1
DNS.5	= *.dc02.$1
DNS.6	= *.dc03.$1
DNS.7	= *.dc04.$1
DNS.8	= *.dc05.$1
DNS.9	= *.dc06.$1
DNS.10	= *.dc07.$1
DNS.11	= *.dc08.$1
DNS.12	= *.dc09.$1
DNS.13	= *.dc10.$1
DNS.14	= *.dc11.$1
DNS.15	= *.dc12.$1
DNS.16	= *.dc13.$1
DNS.17	= *.dc14.$1
DNS.18	= *.dc15.$1
DNS.19	= *.dc16.$1
DNS.20	= *.dc17.$1
DNS.21	= *.dc18.$1
DNS.22	= *.dc19.$1
DNS.23	= *.dc20.$1
DNS.24	= *.dev01.$1
DNS.25	= *.dev02.$1
DNS.26	= *.dev03.$1
DNS.27	= *.dev04.$1
DNS.28	= *.dev05.$1
DNS.29	= *.dev06.$1
DNS.30	= *.dev07.$1
DNS.31	= *.dev08.$1
DNS.32	= *.dev09.$1
DNS.33	= *.dev10.$1
DNS.34	= *.dev11.$1
DNS.35	= *.dev12.$1
DNS.36	= *.dev13.$1
DNS.37	= *.dev14.$1
DNS.38	= *.dev15.$1
DNS.39	= *.dev16.$1
DNS.40	= *.dev17.$1
DNS.41	= *.dev18.$1
DNS.42	= *.dev19.$1
DNS.43	= *.dev20.$1
EOF
