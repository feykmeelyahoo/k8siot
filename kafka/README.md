https://docs.confluent.io/current/installation/installing_cp/cp-helm-charts/docs/index.html

git clone  https://github.com/confluentinc/cp-helm-charts.git
helm repo add confluentinc https://confluentinc.github.io/cp-helm-charts/
helm install confluentinc/cp-helm-charts --name my-confluent-oss --values myValues.yaml --namespace cp-kafka

Then 

kubectl edit svc my-confluent-oss-cp-kafka

add 	- 	nodePort: 31090
change	- 	type: NodePort
