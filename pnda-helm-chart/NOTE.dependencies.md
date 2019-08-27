# Note about PNDA's charts of dependencies

Charts in *charts* folder are external dependencies to PNDA.

The origin of these charts is mixed: copied from a public repo, copied from a public repo with minor modifications or new.

## Copied from public repo

Next charts are directly downloaded from their public repo:

- cp-kafka [confluent repo](https://confluentinc.github.io/cp-helm-charts/).
- cp-kafka-connect [confluent repo](https://confluentinc.github.io/cp-helm-charts/).
- cp-kafka-rest [confluent repo](https://confluentinc.github.io/cp-helm-charts/).
- cp-ksql-server [confluent repo](https://confluentinc.github.io/cp-helm-charts/).
- cp-schema-registry [confluent repo](https://confluentinc.github.io/cp-helm-charts/).
- cp-zookeeper [confluent repo](https://confluentinc.github.io/cp-helm-charts/).
- grafana [helm stable repo](https://kubernetes-charts.storage.googleapis.com/).
- kafka-manager [helm stable repo](https://kubernetes-charts.storage.googleapis.com/).
- redis [helm stable repo](https://kubernetes-charts.storage.googleapis.com/).

## Copied from public repo with minor modifications

### jupyterhub

Downloaded from  [jupyterhub repo](https://jupyterhub.github.io/helm-chart/). with the following **modifications**:

- Added jupyterhub *subdomain-service.yaml* service to resolve singleuser pods (jupyter-{username}.jupyterhub) through kubernetes DNS.
That way spark executors can communicate with singleuser pods for spark notebooks.

## New charts
Next charts were created:
- hdfs (based on [helm stable repo](https://kubernetes-charts.storage.googleapis.com/) hadoop chart, but only with hdfs component).
- hbase
- opentsdb
- spark-standalone
- jmxproxy