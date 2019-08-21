#Linux Makineler İçin Prometheous Node Exporter Yüklenmesi
 
wget https://github.com/prometheus/node_exporter/releases/download/v*/node_exporter-*.*-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64
./node_exporter

#9100 portundan çalışıyor.

#Promethoes Node Exporter Ayarı
#prometheus.yml içine

scrape_configs:
- job_name: 'node'
  static_configs:
  - targets: ['localhost:9100']

./prometheus --config.file=./prometheus.yml ile prometheous ilgili konfigürasyon ile başlatılıyor.
#Veriler node_ başlığı ile birlikte gelir.

#Snmp Node Exporter Yüklemesi

https://github.com/prometheus/snmp_exporter/releases adresinden indirilir
./snmp_exporter ile çalıştırılıyor. 9116 portu ile çalışıyor

#prometheus.yml içine

scrape_configs:
  - job_name: 'snmp'
    static_configs:
      - targets:
        - 192.168.1.2  # SNMP ipsi
    metrics_path: /snmp
    params:
      module: [if_mib]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9116  # node ipsi

#snmp sadece varsayılan olarak sistem uptime bilgisi gönderir. sysUptime isiminde.
#Grafanada ilgili dashboardlar oluşturulur. 

#Kubernetes  ile birlikte çalıştırmak
#Node ve Snmp exportler podlarda çalıştırılıyor. https://github.com/helm/charts/tree/master/stable/prometheus-node-exporter
#https://github.com/helm/charts/blob/master/stable/prometheus/values.yaml helm chart values dosyasına prometheus.yml: kısmına aşağıdakiler eklenir ve öyle başlatılır.

scrape_configs:
- job_name: 'node'
  static_configs:
  - targets: ['localhost:9100']
 - job_name: 'snmp'
    static_configs:
      - targets:
        - 192.168.1.2  # SNMP ipsi
    metrics_path: /snmp
    params:
      module: [if_mib]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:9116  # node ipsi
