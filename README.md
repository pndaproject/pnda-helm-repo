# PNDA Helm Repo

**The PNDA Helm charts are under active development and is not suited for production use.**

![logo](kube-pnda_icon.png)

## Overview

The PNDA helm charts enable you to deploy PNDA on Kubernetes, the scalable, open source big data analytics platform for networks and services.
It includes references to official helm charts (confluent-platform, jupyterhub, grafana, etc.) and custom helm charts (hbase, hdfs, opentsdb, etc.).

The main chart is named [pnda](pnda) and defines all the pnda components as [requirements](pnda/requirements.yaml). A helm client use the main chart to deploy pnda platform on Kuberentes. The platform componentes and resources can be customized with a user provided profile.yaml (See [Configuration Section](#Configuration)).

### Requirements

Tested with:

- Kubernetes v1.11
- Helm v2.13

## Quick Setup

Add this repo to your helm:
```
helm repo add pndaproject https://pndaproject.github.io/pnda-helm-repo/
helm repo update
```

Install to your kubernetes cluster:
```
helm install --name pnda pndaproject/pnda
```

## Configuration
PNDA is configured by default for minimum resource requirements (for example HA is disabled).

The default configuration of PNDA can be modified providing a yaml file with the modifications. This yaml file is named *PNDA profile*. 
The source repository contains a profile folder with several pnda profile examples:

- [profile/red-pnda.yml](profile/red-pnda.yml): profile to deploy pnda in a single computer for development purposes.
- [profile/pico.yml](profile/pico.yml): profile to deploy pnda in a cluster with minimum resources.

To create your own PNDA profile you can start inspecting the main pnda default configuration file [values.yaml](pnda/values.yaml).

Helm will configure all PNDA services and components with values from files with this priority order:

profile.yaml > pnda/values.yaml > componentX/values.yaml

Here is a list of the default value files of all PNDA Components.

PNDA internal management services:
- console-backend-data-logger [values.yaml](pnda/console-backend-data-logger/values.yaml)
- console-backend-data-manager [values.yaml](pnda/console-backend-data-manager/values.yaml)
- console-frontend [values.yaml](pnda/console-frontend/values.yaml)
- data-service [values.yaml](pnda/data-service/values.yaml)
- deployment-manager [values.yaml](pnda/deployment-manager/values.yaml)
- package-repository [values.yaml](pnda/package-repository/values.yaml)

PNDA components:
- hdfs [values.yaml](hdfs/values.yaml).
- hbase [values.yaml](hbase/values.yaml).
- openstsdb [values.yaml](opentsdb/values.yaml).
- spark-standalone [values.yaml](spark-standalone/values.yaml).
- jupyterhub [values.yaml](https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/0.8.2/jupyterhub/values.yaml).
- cp-platform [values.yaml](https://github.com/confluentinc/cp-helm-charts/blob/master/values.yaml).
- cp-zookeeper [values.yaml](https://github.com/confluentinc/cp-helm-charts/blob/master/charts/cp-zookeeper/values.yaml).
- cp-kafka [values.yaml](https://github.com/confluentinc/cp-helm-charts/blob/master/charts/cp-kafka/values.yaml).


## Deploying from Sources

Charts from [Helm repo](https://pndaproject.github.io/pnda-helm-repo/) are synchronized with the master branch of this [source repo](https://github.com/pndaproject/pnda-helm-repo).
If you want to deploy charts from the development branch or modify current charts you have to deploy the charts from source.

First, you have to add the external 3rd party repos to helm:

```
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo add confluent https://confluentinc.github.io/cp-helm-charts/
helm repo update
```

You must always update the dependencies before helm installing or helm updating the pnda chart:

```
helm dep update pnda/
helm install --name src-pnda pnda/ [-f profile/red-pnda.yaml]
```

## Tests

### Testing locally with minikube

Deploy a local kubernetes with at leat 3 cpus and 4GB RAM with ingress enabled:

```
minikube start --memory=4096 --cpus=3 --kubernetes-version v1.11.8
minikube addons enable ingress
```

Initialize the local Helm CLI and also install Tiller into minikube in one step:

```
helm init --history-max 200
```

Download red-pnda.yaml profile for local deployment:
```
wget https://github.com/pndaproject/pnda-helm-repo/raw/master/profiles/red-pnda.yaml
```

Install PNDA platform with helm:
```
helm repo add pndaproject https://pndaproject.github.io/pnda-helm-repo/
helm repo update
helm install --name pnda pndaproject/pnda -f red-pnda.yaml
```

Include vhosts entries pointing to minikube VM IP to access web uis.
For example, on a linux client host:

```
echo "\$(minikube ip) console.pnda.io notebooks.pnda.io grafana.pnda.io kafka-manager.pnda.io hdfs.pnda.io spark.pnda.io" | sudo tee -a /etc/hosts
```

- Access PNDA console at http://console.pnda.io with user pnda password pnda
- Access jupyerhub at http://notebooks.pnda.io with user pnda password pnda
- Access grafana at http://grafana.pnda.io with user pnda password pnda
- Access hdfs namenode management ui at http://hdfs.pnda.io
- Access kafka-manager ui at http://kafka-manager.pnda.io

### Testing locally with microk8s

As an alternative for local deployment you can use [microk8s](https://microk8s.io/). Microk8s does not deploy kubernetes in a virtual machine as minikube, and provide interesting addons such us prometheus or istio. 
Install microk8s in your local Linux Machine. Then enable this addons for microk8s:

```
microk8s.enable dns dashboard ingress storage
```

You can check if microk8s local cluster health with

```
microk8s.inspect
```

This command may output you have to enable ip tables forwarding with:
```
sudo iptables -P FORWARD ACCEPT
```

To make helm work with microk8s you have to point microk8s.kubectl to kubectl:
```
alias kubectl=microk8s.kubectl
```

Initialize the local Helm CLI and also install Tiller into minikube in one step:

```
helm init --history-max 200
```

Download red-pnda.yaml profile for local deployment:
```
wget https://github.com/pndaproject/pnda-helm-repo/raw/master/profiles/red-pnda.yaml
```

Install PNDA platform with helm:
```
helm repo add pndaproject https://pndaproject.github.io/pnda-helm-repo/
helm repo update
helm install --name pnda pndaproject/pnda -f red-pnda.yaml
```

Include vhosts entries pointing to your localhost to access web uis.
For example, on a linux client host:

```
echo "127.0.0.1 console.pnda.io notebooks.pnda.io grafana.pnda.io kafka-manager.pnda.io hdfs.pnda.io spark.pnda.io" | sudo tee -a /etc/hosts
```

- Access PNDA console at http://console.pnda.io with user pnda password pnda
- Access jupyerhub at http://notebooks.pnda.io with user pnda password pnda
- Access grafana at http://grafana.pnda.io with user pnda password pnda
- Access hdfs namenode management ui at http://hdfs.pnda.io
- Access kafka-manager ui at http://kafka-manager.pnda.io


## Credits

- [Zero to Jupyterhub with Kubernetes](https://zero-to-jupyterhub.readthedocs.io/en/latest/)
- [Confluent Platform helm chart](https://github.com/confluentinc/cp-helm-charts)
