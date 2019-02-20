wget https://raw.githubusercontent.com/Yolean/kubernetes-kafka/master/yahoo-kafka-manager/kafka-manager.yml
change value: zookeeper.kafka:2181 to 
value: my-confluent-oss-cp-zookeeper

wget https://raw.githubusercontent.com/Yolean/kubernetes-kafka/master/yahoo-kafka-manager/kafka-manager-service.yml

 edit nodePort and set 32480
