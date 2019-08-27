#!/bin/bash

. scripts/common.sh

function lint_chart() {
  chart_name=$1
  chart_file=$2

  echo -e "==> ${GREEN}Linting $chart_name...${RS}"
  output=`helm lint $chart_file --debug 2> /dev/null`
  if [ $? -ne 0 ]; then
    echo -e "===> ${RED} Linting errors for chart $chart_name ${RS}"
    echo -e "$output" | grep "\\["
    exit 1
  fi
  echo -e "$output" | grep "\\["
}

# Jenkins's working dir is not pnda-helm-repo, so copy to tmp dir before linting
if [[ $JENKINS_HOME ]]; then
  rm -rf /tmp/pnda-helm-chart
  cp -R pnda-helm-chart /tmp/
  cd /tmp
fi

lint_chart pnda-helm-chart pnda-helm-chart

for chart in `ls -1 pnda-helm-chart/charts`; do
  lint_chart $chart pnda-helm-chart/charts/$chart
done

echo -e "==> ${GREEN} No linting errors${RS}"
