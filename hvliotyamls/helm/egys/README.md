kubectl create configmap init-db --from-file=path/to/scripts
helm install bitnami/cassandra --set initDBConfigMap=init-db
helm install bitnami/cassandra -n bitcass --set dbUser.password=cassandra --set cluster.replicaCount=3 --set cluster.seedCount=2
helm install bitnami/cassandra -n bitcass --set initDBConfigMap=init-db --set dbUser.password=cassandra --set cluster.replicaCount=3 --set cluster.seedCount=2
helm install bitnami/cassandra -n bitcass --set initDBConfigMap=init-db --set dbUser.password=cassandra --set image.pullPolicy=IfNotPresent

NOTES:
** Please be patient while the chart is being deployed **

Cassandra can be accessed through the following URLs from within the cluster:

  - CQL: bitcass-cassandra.egys.svc.cluster.local:9042
  - Thrift: bitcass-cassandra.egys.svc.cluster.local:9160

To get your password run:

   export CASSANDRA_PASSWORD=$(kubectl get secret --namespace egys bitcass-cassandra -o jsonpath="{.data.cassandra-password}" | base64 --decode)

Check the cluster status by running:

   kubectl exec -it --namespace egys $(kubectl get pods --namespace egys -l app=cassandra,release=bitcass -o jsonpath='{.items[0].metadata.name}') nodetool status

To connect to your Cassandra cluster using CQL:

1. Run a Cassandra pod that you can use as a client:

   kubectl run --namespace egys bitcass-cassandra-client --rm --tty -i --restart='Never' \
   --env CASSANDRA_PASSWORD=$CASSANDRA_PASSWORD \
    \
   --image docker.io/bitnami/cassandra:3.11.4 -- bash

2. Connect using the cqlsh client:

   cqlsh -u cassandra -p $CASSANDRA_PASSWORD bitcass-cassandra

To connect to your database from outside the cluster execute the following commands:

   kubectl port-forward --namespace egys svc/bitcass-cassandra 9042:9042 &
   cqlsh -u cassandra -p $CASSANDRA_PASSWORD 127.0.0.1 9042



readinessProbe:
  httpGet: # make an HTTP request
    port: 8080 # port to use
    path: /readiness # endpoint to hit
    scheme: HTTP # or HTTPS
  initialDelaySeconds: 3 # how long to wait before checking
  periodSeconds: 3 # how long to wait between checks
  successThreshold: 1 # how many successes to hit before accepting
  failureThreshold: 1 # how many failures to accept before failing
  timeoutSeconds: 1


kubectl run --namespace egys bitcass-cassandra-client --env CASSANDRA_PASSWORD=$CASSANDRA_PASSWORD --image docker.io/bitnami/cassandra:3.11.4

