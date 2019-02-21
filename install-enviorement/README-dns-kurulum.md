# Dns (Bind) Kurulumları
İlk olarak gerekli paketlerin kurulumları yapılır.

```
yum install bind bind-utils -y
```
Bind config dosyası eklenir.

> Forwarder alanı değiştirilmelidir.

```
cat <<EOF > /etc/named.conf
options {
	listen-on port 53 { any; };
	directory 	"/var/named";
	dump-file 	"/var/named/data/cache_dump.db";
	statistics-file "/var/named/data/named_stats.txt";
	memstatistics-file "/var/named/data/named_mem_stats.txt";
	allow-query     { any; };
	allow-query-cache     { any; };
	forwarders {
		10.150.0.7;
	};
	recursion yes;
	dnssec-enable yes;
	dnssec-validation yes;
	bindkeys-file "/etc/named.iscdlv.key";
	managed-keys-directory "/var/named/dynamic";
	pid-file "/run/named/named.pid";
	session-keyfile "/run/named/session.key";
};
logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

zone "." IN {
	type hint;
	file "named.ca";
};
include "/etc/named.rfc1912.zones";
include "/etc/named.root.key";
zone "domain" IN {
	type master;
	file "domain.zone";
	allow-update { none; };
};
EOF
```
Bind kurulum dosyasında belirtilen zone dosyası eklenir. Ip ve domain bilgisi eklemeden önce değiştirilmelidir.

```
cat <<EOF > /var/named/domain.zone
$TTL	86400
$ORIGIN domain.
@  1D  IN  SOA ns1.domain. hostmaster.domain. (
			      2002022401 ; serial
			      3H ; refresh
			      15 ; retry
			      1w ; expire
			      3h ; nxdomain ttl
			     )
       IN  NS     ns1.domain.
       IN  MX  10 mail.domain.
; server host definitions
ns1    IN  A      10.151.102.30
mail    IN  CNAME  ns1.domain.
repo	IN	A	10.151.102.27
engine	IN	A	10.151.102.200
server1	IN	A	10.151.102.27
server2	IN	A	10.151.102.28
server3	IN	A	10.151.102.29
server4	IN	A	10.151.102.30
prometheus001	IN	A	10.151.102.50
vm000	IN	A	10.151.102.40
vm001	IN	A	10.151.102.41
vm002	IN	A	10.151.102.42
vm003	IN	A	10.151.102.43
vm004	IN	A	10.151.102.44
k8s-master001	IN	A	10.151.102.45
k8s-node001	IN	A	10.151.102.46
k8s-node002	IN	A	10.151.102.47
k8s-node003	IN	A	10.151.102.48
EOF
service named restart
```

Client sunucularda dns server değiştirilip kullanılabilir.

Hosted-engine üzerinde açılan sunucuların dns kayıtlarını ekleyen bir script hazırladık. Şuanki ortamda server4 üzerinde çalışmaktadır. Kısaca engine api üzerinden vm isimlerini ve ip adreslerini alıp dns kaydı yoksa veya farklıysa dns kaydı ekliyor.

```
[root@Server4 ~]# crontab -l|grep Dns
*/30 * * * * /bin/bash /usr/local/bin/DnsUpdaterFromEngine.sh
[root@Server4 ~]# 
```

