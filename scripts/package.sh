#!/bin/bash

rm -f docs/*.tgz
rm -f docs/*.yaml

for CHART in hdfs hbase opentsdb spark-standalone pnda
do

helm dep update $CHART
helm package -d docs $CHART
rm -rf $CHART/charts

done

helm repo index docs/
