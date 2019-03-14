# Harbor

## Using Docker Compose

**Attention:** Installation And Removal with docker-compose

https://www.vultr.com/docs/how-to-install-harbor-on-centos-7
https://blog.inkubate.io/how-to-use-harbor-private-registry-with-kubernetes/

https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309

## Install Harbor

```
sudo ./install.sh --with-notary --with-clair
```
## Remove Harbor

```
docker-compose down --volumes --remove-orphans
docker volume prune
rm -rf /var/log/harbor /data/*
```
