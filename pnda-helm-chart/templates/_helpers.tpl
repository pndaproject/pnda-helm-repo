{{/*
Standard Labels from Helm documentation https://helm.sh/docs/chart_best_practices/#labels-and-annotations
*/}}

{{- define "pnda.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/part-of: {{ .Chart.Name }}
{{- end -}}

{{- define "pnda.console-backend-data-logger.name" -}}
{{- $name := default "console-backend-data-logger" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "pnda.console-backend-data-logger.labels" -}}
app.kubernetes.io/name: {{ include "pnda.console-backend-data-logger.name" . }}
{{ include "pnda.labels" . }}
{{- end -}}

{{- define "pnda.console-backend-data-manager.name" -}}
{{- $name := default "console-backend-data-manager" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "pnda.console-backend-data-manager.labels" -}}
app.kubernetes.io/name: {{ include "pnda.console-backend-data-manager.name" . }}
{{ include "pnda.labels" . }}
{{- end -}}

{{- define "pnda.console-frontend.name" -}}
{{- $name := default "console-frontend" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "pnda.console-frontend.labels" -}}
app.kubernetes.io/name: {{ include "pnda.console-frontend.name" . }}
{{ include "pnda.labels" . }}
{{- end -}}

{{- define "pnda.data-service.name" -}}
{{- $name := default "data-service" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "pnda.data-service.labels" -}}
app.kubernetes.io/name: {{ include "pnda.data-service.name" . }}
{{ include "pnda.labels" . }}
{{- end -}}

{{- define "pnda.deployment-manager.name" -}}
{{- $name := default "deployment-manager" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "pnda.deployment-manager.labels" -}}
app.kubernetes.io/name: {{ include "pnda.deployment-manager.name" . }}
{{ include "pnda.labels" . }}
{{- end -}}

{{- define "pnda.package-repository.name" -}}
{{- $name := default "package-repository" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "pnda.package-repository.labels" -}}
app.kubernetes.io/name: {{ include "pnda.package-repository.name" . }}
{{ include "pnda.labels" . }}
{{- end -}}

{{- define "pnda.platform-testing.name" -}}
{{- $name := default "platform-testing" .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "pnda.platform-testing.labels" -}}
app.kubernetes.io/name: {{ include "pnda.platform-testing.name" . }}
{{ include "pnda.labels" . }}
{{- end -}}