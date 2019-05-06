#!/bin/bash

rm -rf charts/*

helm package -d charts hdfs
helm package -d charts hbase
helm package -d charts spark-standalone
helm package -d charts opentsdb
helm dep update pnda
helm package -d charts pnda
helm repo index charts --url https://gradiant.github.io/pnda-charts
