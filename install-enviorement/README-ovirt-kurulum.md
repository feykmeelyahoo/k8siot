# Ovirt Kurulumları



İlk olarak eğer eklenmediyse local repolar eklenir.

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

> network interface bond yapılmışsa eğer adının device adının bond ile başlaması gerekiyor. Diğer şekilde ovirt kurulumda sorun yaşanıyor.
> Aşağıdaki örnekte kısaca nm-bond isimli device adının bond0 olarak değiştirilmesi örneği verilmiştir.

```
sed -i 's/nm-bond/bond0/g' /etc/sysconfig/network-scripts/ifcfg-*
```

Network ayarlandıktan sonra hazırlanan dns servis ayarları yapılır.

```
sed -i 's/DNS1=.*/DNS1=10.151.102.30/g' /etc/sysconfig/network-scripts/ifcfg-Bond
service network restart
```

Dns, repo ve network ayarlandıktan sonra ovirt-engine için kurulum aşağıdaki komut ile yapılır.

```
yum install ovirt-engine-appliance -y
```

Appliance kurulumu sonrası hosted-engine kurulumu yapılır. Hosted-engine kurulumu sırasında tüm adımlar tek tek de ayarlanabilir veya aşağıdaki answer dosyası kullanılabilir. Aşağıdaki answer dosyasında storage iscsi üzerinden alınacak şekilde ayarlanmıştır. Farklı seçenekler için dosya üzerinde ilgili yerleri değiştirebilir veya silebilirsiniz. Sildiğiniz zaman kurulum sırasında gerekli cevabı size soracaktır.

Hazır dosya olmadan;

```
hosted-engine --deploy --noansible
```
Dosya ile 
```
hosted-engine --deploy --noansible  --config-append=/tmp/answer.conf
```

Örnek answer dosya içeriği
```
[environment:default]
OVEHOSTED_CORE/confirmSettings=bool:True
OVEHOSTED_CORE/deployProceed=bool:True
OVEHOSTED_CORE/rollbackProceed=none:None
OVEHOSTED_CORE/screenProceed=none:None
OVEHOSTED_CORE/upgradeProceed=none:None
OVEHOSTED_ENGINE/allowGlusterReplicaOne=none:None
OVEHOSTED_ENGINE/clusterName=str:Default
OVEHOSTED_ENGINE/datacenterName=none:None
OVEHOSTED_ENGINE/enableHcGlusterService=none:None
OVEHOSTED_ENGINE/insecureSSL=none:None
OVEHOSTED_NETWORK/bridgeName=str:ovirtmgmt
OVEHOSTED_NETWORK/firewallManager=str:iptables
OVEHOSTED_NETWORK/fqdn=str:engine.domain
OVEHOSTED_NETWORK/gateway=str:10.151.102.1
OVEHOSTED_NOTIF/destEmail=str:root@localhost
OVEHOSTED_NOTIF/smtpPort=str:25
OVEHOSTED_NOTIF/smtpServer=str:localhost
OVEHOSTED_NOTIF/sourceEmail=str:root@localhost
OVEHOSTED_STORAGE/LunID=str:36f86eee1008d44e304f0cb4400000003
OVEHOSTED_STORAGE/confImageUUID=str:17f476ec-7e79-4a7e-af11-b1a202174bba
OVEHOSTED_STORAGE/confVolUUID=str:37d9c8e1-c880-4782-ac26-744c999b4ad7
OVEHOSTED_STORAGE/connectionUUID=str:2d2c954f-7e02-4473-934e-fc2ec2775749
OVEHOSTED_STORAGE/domainType=str:iscsi
OVEHOSTED_STORAGE/iSCSIPortal=str:1
OVEHOSTED_STORAGE/iSCSIPortalIPAddress=str:192.168.1.100
OVEHOSTED_STORAGE/iSCSIPortalPort=str:3260
OVEHOSTED_STORAGE/iSCSIPortalUser=str:
OVEHOSTED_STORAGE/iSCSITargetName=str:iqn.2006-08.com.huawei:oceanstor:2100f86eee8d44e3::20000:192.168.1.100
OVEHOSTED_STORAGE/imgSizeGB=str:50
OVEHOSTED_STORAGE/imgUUID=str:5ec79506-5121-45cf-b8ad-317a6bdac88d
OVEHOSTED_STORAGE/lockspaceImageUUID=str:969dd065-ca0a-4b30-a9e7-e3194105e1f2
OVEHOSTED_STORAGE/lockspaceVolumeUUID=str:9a4eddff-ae68-410c-9dc1-51b7a9d5acdd
OVEHOSTED_STORAGE/metadataImageUUID=str:cbd7e37b-947e-4387-88b3-960cb32d990d
OVEHOSTED_STORAGE/metadataVolumeUUID=str:44816109-f7e0-4bc2-96b9-97f15a4e62e5
OVEHOSTED_STORAGE/mntOptions=none:None
OVEHOSTED_STORAGE/sdUUID=str:ac82708b-d74c-4a58-a3fd-cda4203c8542
OVEHOSTED_STORAGE/spUUID=str:00000000-0000-0000-0000-000000000000
OVEHOSTED_STORAGE/storageDatacenterName=str:hosted_datacenter
OVEHOSTED_STORAGE/storageDomainConnection=none:None
OVEHOSTED_STORAGE/storageDomainName=str:hosted_storage
OVEHOSTED_STORAGE/vgUUID=str:8BOyg2-wfhz-baeH-hY8N-c6G6-uTjL-0Ne38V
OVEHOSTED_STORAGE/volUUID=str:60d8efca-5b2b-4464-be5b-990866898530
OVEHOSTED_VDSM/caSubject=str:/C=EN/L=Test/O=Test/CN=TestCA
OVEHOSTED_VDSM/consoleType=str:vnc
OVEHOSTED_VDSM/cpu=str:model_Skylake-Server
OVEHOSTED_VDSM/pkiSubject=str:/C=EN/L=Test/O=Test/CN=Test
OVEHOSTED_VDSM/spicePkiSubject=str:C=EN, L=Test, O=Test, CN=Test
OVEHOSTED_VM/automateVMShutdown=bool:True
OVEHOSTED_VM/cdromUUID=str:0ff2aa26-1f05-4582-b617-db3975511782
OVEHOSTED_VM/cloudInitISO=str:generate
OVEHOSTED_VM/cloudinitExecuteEngineSetup=bool:True
OVEHOSTED_VM/cloudinitInstanceDomainName=str:domain
OVEHOSTED_VM/cloudinitInstanceHostName=str:engine.domain
OVEHOSTED_VM/cloudinitVMDNS=str:10.151.102.30
OVEHOSTED_VM/cloudinitVMETCHOSTS=bool:False
OVEHOSTED_VM/cloudinitVMStaticCIDR=str:10.151.102.200/24
OVEHOSTED_VM/cloudinitVMTZ=str:Europe/Istanbul
OVEHOSTED_VM/consoleUUID=str:c7d0784e-a477-44bd-a30c-2275acda8017
OVEHOSTED_VM/emulatedMachine=str:pc
OVEHOSTED_VM/nicUUID=str:ac1c21f5-7e0d-462f-8e35-10dd26322956
OVEHOSTED_VM/ovfArchive=str:/usr/share/ovirt-engine-appliance/ovirt-engine-appliance-4.2-20190121.1.el7.ova
OVEHOSTED_VM/rootSshAccess=str:yes
OVEHOSTED_VM/rootSshPubkey=str:
OVEHOSTED_VM/vmCDRom=none:None
OVEHOSTED_VM/vmMACAddr=str:00:16:3e:23:18:fd
OVEHOSTED_VM/vmMemSizeMB=int:16384
OVEHOSTED_VM/vmUUID=str:6d2aee30-4274-4a9f-9f71-e78080ac3075
OVEHOSTED_VM/vmVCpus=str:4
```
> Hosted engine A kaydı domainde tanımlı olmalıdır.

Kurulum sonrası https://engine.domain adresinden hosted-engine erişilebilir durumda olacaktır.

ÖNEMLİ NOT:

> Ovirt 4.2.8 için Engine vm kurulum/deploy sırasında 4 verilmesine rağmen default olarak 24 gelmektedir. Acildiktan sonra engine cpu count u vm edit ile engine arayüz üzerinden güncellenmelidir!!!!!!! Aksi halde engine ilk reboot poweroff durumlarında max vcpu degeri cpu degerinden düşük oldugu için hata vererek açılmıyor.
> Eğer bu şekilde bir durum olursa gerekli adımlar;
> /var/run/ovirt-hosted-engine-ha/vm.conf içerisindeki xmlBase64 değeri alınır decode edilir.
> Decode edilen text üzerinde <vcpu current=4>16<vcpu> şeklinde core sayısına bağlı olarak güncellenir. Aynı zamanda cpus satırı max cpu count a göre ayarlanır.
> Gerekli değişikliklerden sonra text yeniden base64 encode edilip /usr/lib/python2.7/site-packages/ovirt_hosted_engine_setup/vmconf.py dosyasında "xml = base64.standard_b64decode(params['xmlBase64'])" bir alt satırına 'xml = base64.standard_b64decode("encode_ettiginiz_text")' olarak eklenir ve /usr/lib/python2.7/site-packages/ovirt_hosted_engine_setup/vmconf.pyc dosyası silinir.
> Son olarak tekrar ``` hosted_engine --vm-start ``` calistirilir.

 

Eğer hosted-engine farklı bir isimle de çalışsın istenirse aşağıdaki gibi SSO_ALTERNATE_ENGINE_FQDNS eklenebilir.

```
/etc/ovirt-engine/engine.conf.d/11-setup-sso.conf

[root@engine ~]# cat /etc/ovirt-engine/engine.conf.d/11-setup-sso.conf
ENGINE_SSO_CLIENT_ID="ovirt-engine-core"
ENGINE_SSO_CLIENT_SECRET="pMO1h1CDy6BfQfGFDDfAGy8ohuVfy6a7"
ENGINE_SSO_AUTH_URL="https://${ENGINE_FQDN}:443/ovirt-engine/sso"
ENGINE_SSO_SERVICE_URL="https://${ENGINE_FQDN}:443/ovirt-engine/sso"
ENGINE_SSO_SERVICE_SSL_VERIFY_HOST=false
ENGINE_SSO_SERVICE_SSL_VERIFY_CHAIN=true
SSO_ALTERNATE_ENGINE_FQDNS="engine"
SSO_ENGINE_URL="https://${ENGINE_FQDN}:443/ovirt-engine/"

systemctl restart ovirt-engine.service
```

Hosted-engine üzerinde açılan sunucuların dns kayıtlarını ekleyen bir script hazırladık. Şuanki ortamda server4 üzerinde çalışmaktadır. Kısaca engine api üzerinden vm isimlerini ve ip adreslerini alıp dns kaydı yoksa veya farklıysa dns kaydı ekliyor.

```
[root@Server4 ~]# crontab -l|grep Dns
*/30 * * * * /bin/bash /usr/local/bin/DnsUpdaterFromEngine.sh
[root@Server4 ~]# 
```
