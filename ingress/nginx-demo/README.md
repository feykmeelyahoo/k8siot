kubectl create secret tls havelsan.io --key havelsan.io.key --cert havelsan.io.crt
cd k8siot/ingress/nginx-demo
ka kube-dash-ingress.yaml

192.168.104.51 k8s-01 kubernetes-dashboard.havelsan.io alertmanager.havelsan.io grafana.havelsan.io pushgateway.havelsan.io prometheus.havelsan.io traefik-ui.minikube nginx.havelsan.io docker-reg.havelsan.com
