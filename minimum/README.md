helm install bitnami/cassandra -n bitcass --set dbUser.password=cassandra --set cluster.replicaCount=3 --set cluster.seedCount=2
