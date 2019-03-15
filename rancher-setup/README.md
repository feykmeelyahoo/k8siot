
If you already have /var/lib/rancher copied to host

sudo docker run -d --restart=unless-stopped -v /opt/rancher:/var/lib/rancher -v /root/iot-cluster-setup/certs:/etc/rancher/ssl -p 80:80 -p 443:443 rancher/rancher:latest


else 

sudo docker run -d --restart=unless-stopped -v /root/iot-cluster-setup/certs:/etc/rancher/ssl -p 80:80 -p 443:443 rancher/rancher:latest
