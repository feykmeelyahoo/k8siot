# Local Centos repo kurulumları ve ayarlanması

>Bu kurulumda repo domain bilgisi "repo.domain" olarak ayarlanmıştır. Domain bilgisine göre gerekli yerleri değiştirilmesi gerekmektedir.

## Repo serverın kurulum adımları
İlk olarak gerekli repo ve araçların kurulumlarının yapılması gerekmektedir. 
```
yum install http://resources.ovirt.org/pub/yum-repo/ovirt-release42.rpm
yum install createrepo  yum-utils nginx
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```
Firewall erişim izinleri tanımlanır.
```
firewall-cmd --zone=public --permanent --add-service=http
service firewalld restart
```
Kurulumlar sonrasında repo sync işlemlerine başlanabilir.
```
for repo in $(cat <<EOF
base
updates
centosplus
centos-sclo-rh-release
docker-ce-stable
extras
kubernetes
ovirt-4.2
ovirt-4.2-centos-gluster312
ovirt-4.2-centos-opstools
ovirt-4.2-centos-ovirt42
ovirt-4.2-centos-qemu-ev
ovirt-4.2-epel
ovirt-4.2-virtio-win-latest
updates
EOF
);do
	if [[ $repo =~ kubernetes ]] || [[ $repo =~ docker ]];
	then
		REPOSYNC_PARAMS="-l -d -m --repoid=$repo --download-metadata --download_path=/var/www/html/repos/"
	else
		REPOSYNC_PARAMS="-l -d -m --repoid=$repo --newest-only --download-metadata --download_path=/var/www/html/repos/"
	fi
	echo $repo create;
	mkdir -p /var/www/html/repos/$repo
	reposync $REPOSYNC_PARAMS
	createrepo /var/www/html/repos/$repo;
done
```
Bazı repolarda sorun yaşanabiliyor, aşağıdaki örnekle çözülebilir.
```
cd /var/www/html/repos/ovirt-4.2-centos-opstools/repodata;for file in $(curl -s  http://mirror.centos.org/centos/7/opstools/x86_64/repodata/|cut -d\= -f5|cut -d\< -f1|cut -d\> -f1|sed -e 's/"//g'|grep 'xml\|sql');do wget http://mirror.centos.org/centos/7/opstools/x86_64/repodata/$file;done
cd /var/www/html/repos/ovirt-4.2-centos-ovirt42/repodata/;for file in $(curl -s  http://mirror.centos.org/centos/7/virt/x86_64/ovirt-4.2/repodata/|cut -d\= -f5|cut -d\< -f1|cut -d\> -f1|sed -e 's/"//g'|grep 'xml\|sql');do wget http://mirror.centos.org/centos/7/virt/x86_64/ovirt-4.2/repodata/$file;done
createrepo -g comps.xml /var/www/html/repos/base/  
```
Nginx config ayarlanır ve başlatılır.
```
cat <<EOF > /etc/nginx/conf.d/repos.conf
server {
        listen   80;
        server_name  repo.domain; #domain bilgisine gore degistirilmelidir. ip adress de yazilabilir. 
        root   /var/www/html/repos;
        location / {
                index  index.html index.htm;
                autoindex on;	#repo gezinebilmesi icin aktif olmalidir.
        }
}
EOF
service nginx restart
```

## Client sunucuların repo ayarlamalarının yapılması
İlk olarak internet repoları OLDREPOS dizinine taşınır.
```
mkdir -p /etc/yum.repos.d/OLDREPOS
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/OLDREPOS/
#sed -i 's/enabled.*/enabled=0/g' /etc/yum.repos.d/*.repo
```
Sonrasında cache temizlenir ve local repolar eklenir.
```
yum clean all
for repo in $(cat <<EOF
base
updates
centosplus
centos-sclo-rh-release
docker-ce-stable
extras
kubernetes
ovirt-4.2
ovirt-4.2-centos-gluster312
ovirt-4.2-centos-opstools
ovirt-4.2-centos-ovirt42
ovirt-4.2-centos-qemu-ev
ovirt-4.2-epel
ovirt-4.2-virtio-win-latest
updates
EOF
);do echo $repo add;
cat <<EOF > /etc/yum.repos.d/local-$repo.repo
[local-$repo]
name=$repo
baseurl=http://repo.domain/$repo
enabled=1
gpgcheck=0
EOF
done
```

