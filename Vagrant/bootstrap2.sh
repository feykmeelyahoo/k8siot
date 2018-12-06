#!/bin/bash

clear
kubeletPlace=$(find /etc -name kubelet -exec bash -c  "echo {}" \;)
#ifconfig enp0s3 | grep inet | grep -v inet6 | awk '{print $2}'
myIP=$(ifconfig enp0s8 | grep inet | grep -v inet6 | awk '{print $2}')
sed -i "/KUBELET_EXTRA_ARGS\=/ s/$/ --node-ip=${myIP}/" $kubeletPlace
