NOTES:
## ------------------------------------------------------
## Zookeeper
## ------------------------------------------------------
Connection string for Confluent Kafka:
  my-confluent-oss-cp-zookeeper-0.my-confluent-oss-cp-zookeeper-headless:2181,my-confluent-oss-cp-zookeeper-1.my-confluent-oss-cp-zookeeper-headless:2181,...

To connect from a client pod:

1. Deploy a zookeeper client pod with configuration:

    apiVersion: v1
    kind: Pod
    metadata:
      name: zookeeper-client
      namespace: cp
    spec:
      containers:
      - name: zookeeper-client
        image: confluentinc/cp-zookeeper:5.0.1
        command:
          - sh
          - -c
          - "exec tail -f /dev/null"

2. Log into the Pod

  kubectl exec -it zookeeper-client -- /bin/bash

3. Use zookeeper-shell to connect in the zookeeper-client Pod:

  zookeeper-shell my-confluent-oss-cp-zookeeper:2181

4. Explore with zookeeper commands, for example:

  # Gives the list of active brokers
  ls /brokers/ids

  # Gives the list of topics
  ls /brokers/topics

  # Gives more detailed information of the broker id '0'
  get /brokers/ids/0## ------------------------------------------------------
## Kafka
## ------------------------------------------------------
To connect from a client pod:

1. Deploy a kafka client pod with configuration:

    apiVersion: v1
    kind: Pod
    metadata:
      name: kafka-client
      namespace: cp
    spec:
      containers:
      - name: kafka-client
        image: confluentinc/cp-kafka:5.0.1
        command:
          - sh
          - -c
          - "exec tail -f /dev/null"

2. Log into the Pod

  kubectl exec -it kafka-client -- /bin/bash

3. Explore with kafka commands:

  # Create the topic
  kafka-topics --zookeeper my-confluent-oss-cp-zookeeper-headless:2181 --topic my-confluent-oss-topic --create --partitions 1 --replication-factor 1 --if-not-exists

  # Create a message
  MESSAGE="`date -u`"

  # Produce a test message to the topic
  echo "$MESSAGE" | kafka-console-producer --broker-list my-confluent-oss-cp-kafka-headless:9092 --topic my-confluent-oss-topic

  # Consume a test message from the topic
  kafka-console-consumer --bootstrap-server my-confluent-oss-cp-kafka-headless:9092 --topic my-confluent-oss-topic --from-beginning --timeout-ms 2000 --max-messages 1 | grep "$MESSAGE"

#SERKAN
#Change IPs of the hosts

kubectl -n default exec -it kafka-client -- /bin/bash /usr/bin/kafka-console-producer --broker-list 192.168.104.103:31090 --topic test

kubectl -n default exec -it kafka-client -- /bin/bash  /usr/bin/kafka-console-consumer --bootstrap-server 192.168.104.101:31090 --topic test --from-beginning

