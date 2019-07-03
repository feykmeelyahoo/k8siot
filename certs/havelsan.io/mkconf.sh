#!/bin/sh
sslConfPlace=$(openssl version -a | grep OPENSSLDIR | awk '{print $2}' | xargs)
cat <<EOF
$(cat $sslConfPlace"/openssl.cnf")

[SAN]
subjectAltName=DNS:$1,DNS:*.$1,DNS:*.test.$1,DNS:*.dc01.$1,DNS:*.dc02.$1,DNS:*.dc03.$1,DNS:*.dc04.$1,DNS:*.dc05.$1,DNS:*.dc06.$1,DNS:*.dc07.$1,DNS:*.dc08.$1,DNS:*.dc09.$1,DNS:*.dc10.$1,DNS:*.dc11.$1,DNS:*.dc12.$1,DNS:*.dc13.$1,DNS:*.dc14.$1,DNS:*.dc15.$1,DNS:*.dc16.$1,DNS:*.dc17.$1,DNS:*.dc18.$1,DNS:*.dc19.$1,DNS:*.dc20.$1,DNS:*.dev01.$1,DNS:*.dev02.$1,DNS:*.dev03.$1,DNS:*.dev04.$1,DNS:*.dev05.$1,DNS:*.dev06.$1,DNS:*.dev07.$1,DNS:*.dev08.$1,DNS:*.dev09.$1,DNS:*.dev10.$1,DNS:*.dev11.$1,DNS:*.dev12.$1,DNS:*.dev13.$1,DNS:*.dev14.$1,DNS:*.dev15.$1,DNS:*.dev16.$1,DNS:*.dev17.$1,DNS:*.dev18.$1,DNS:*.dev19.$1,DNS:*.dev20.$1
EOF
