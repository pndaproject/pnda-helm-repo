{{/*
This will overwrite default value of zkHosts in kafka-manager Chart
*/}}
{{- define "kafka-manager.zkHosts" -}}
{{- printf "%s-cp-zookeeper:2181" .Release.Name -}}
{{- end -}}
