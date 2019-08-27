# PNDA Helm Repo

**The PNDA Helm charts are under active development and is not suited for production use.**

![logo](kube-pnda_icon.png)

## Overview

The PNDA helm chart enable you to deploy PNDA on Kubernetes, the scalable, open source big data analytics platform for networks and services.
It deploys [PNDA components](pnda-helm-chart/templates) and [Big Data Requirements](pnda-helm-chart/charts). 

A helm client uses the pnda-helm-chart to deploy PNDA platform on Kuberentes. The platform components and requirements can be customized with user provided [profiles](profiles/) (See [Configuration Section](#Configuration)).

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
helm install --name pnda pndaproject/pnda-helm-chart
```

## Configuration
PNDA is configured by default for minimum resource requirements (for example HA is disabled).
Default values for [PNDA components](pnda-helm-chart/templates) and  [Big Data requirements](pnda-helm-chart/charts) are defined in [pnda-helm-chart/values.yaml](pnda-helm-chart/values.yaml) file.

The default configuration of PNDA can be modified providing a yaml file with modified values. This yaml file is named *PNDA profile*. 
The source repository contains a *profiles* folder with several pnda profile examples:
- [profiles/red-pnda.yml](profiles/red-pnda.yml): profile to deploy pnda in a single computer for development purposes.
- [profiles/pico.yml](profiles/pico.yml): profile to deploy pnda in a cluster with minimum resources.
- *More to be added*.

The profile can also modify the default values defined in each [Big Data requirements](pnda-helm-chart/charts).
Here is a list of the default value files of the [Big Data requirements](pnda-helm-chart/charts):
- hdfs [values.yaml](pnda-helm-chart/charts/hdfs/values.yaml).
- hbase [values.yaml](pnda-helm-chart/charts/hbase/values.yaml).
- openstsdb [values.yaml](pnda-helm-chart/charts/opentsdb/values.yaml).
- spark-standalone [values.yaml](pnda-helm-chart/charts/spark-standalone/values.yaml).
- jupyterhub [values.yaml](pnda-helm-chart/charts/values.yaml).

- cp-zookeeper [values.yaml](pnda-helm-chart/charts/cp-zookeeper/values.yaml).
- cp-kafka [values.yaml](pnda-helm-chart/charts/cp-kafka/values.yaml).


## Deploying from Sources

Charts from [Helm repo](https://pndaproject.github.io/pnda-helm-repo/) are synchronized with the master branch of this [source repo](https://github.com/pndaproject/pnda-helm-repo).

If you want to deploy charts from the development branch or modify current charts you have to deploy the charts from source:

```
helm install --name src-pnda pnda-helm-chart/ [-f profiles/red-pnda.yaml]
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
helm install --name pnda pndaproject/pnda-helm-chart -f red-pnda.yaml
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
helm install --name pnda pndaproject/pnda-helm-chart -f red-pnda.yaml
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
