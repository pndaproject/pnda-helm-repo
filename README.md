<aside class="warning">
This repo is deprecated in favor of https://github.com/pndaproject/pnda-helm-chart.
To use pnda helm repo, please follow instructions at https://pndaproject.github.io/pnda-helm-chart
</aside>

# cloud-pnda helm repository

This helm repository provides cloud-pnda charts released from [https://github.com/pndaproject/pnda-helm-chart](https://github.com/pndaproject/pnda-helm-chart)

To add this repo to helm and install a packaged chart, follow this instructions:

Add this repo to your helm:
```
helm repo add pndaproject https://pndaproject.github.io/pnda-helm-repo/
helm repo update
```

Install to your kubernetes cluster:
```
helm install --name pnda pndaproject/cloud-pnda --version=0.1.0-alpha
```
> **NOTE**: currently cloud-pnda has only a "0.1.0-alpha" pre-release thus no "latest" version. You must explicitly set --version=0.1.0-alpha in helm install command.

You may customize your deployment providing a custom values yaml:
```
helm install --name pnda pndaproject/cloud-pnda --version=0.1.0-alpha -f custom.yaml
```

Some custom configuration files are available at [https://github.com/pndaproject/pnda-helm-chart](https://github.com/pndaproject/pnda-helm-chart).
