{{/*
Expand the name of the chart.
*/}}
{{- define "knative-serving.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "knative-serving.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "knative-serving.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "knative-serving.labels" -}}
helm.sh/chart: {{ include "knative-serving.chart" . }}
{{ include "knative-serving.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "knative-serving.selectorLabels" -}}
app.kubernetes.io/name: {{ include "knative-serving.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Activator Selector labels
*/}}
{{- define "knative-serving.activatorSelectorLabels" -}}
app.kubernetes.io/component: activator
{{- end }}

{{/*
Autoscaler Selector labels
*/}}
{{- define "knative-serving.autoscalerSelectorLabels" -}}
app.kubernetes.io/component: autoscaler
{{- end }}

{{/*
Autoscaler HPA Selector labels
*/}}
{{- define "knative-serving.autoscalerHpaSelectorLabels" -}}
app.kubernetes.io/component: autoscaler-hpa
autoscaling.knative.dev/autoscaler-provider: hpa
{{- end }}

{{/*
Controller Selector labels
*/}}
{{- define "knative-serving.controllerSelectorLabels" -}}
app.kubernetes.io/component: controller
{{- end }}

{{/*
Webhook Selector labels
*/}}
{{- define "knative-serving.webookSelectorLabels" -}}
app.kubernetes.io/component: webhook
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "knative-serving.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "knative-serving.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the activator service account to use
*/}}
{{- define "knative-serving.activatorServiceAccountName" -}}
{{- if .Values.activator.serviceAccount.create }}
{{- default (printf "%s-activator" (include "knative-serving.fullname" .)) .Values.activator.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.activator.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the controller service account to use
*/}}
{{- define "knative-serving.controllerServiceAccountName" -}}
{{- if .Values.controller.serviceAccount.create }}
{{- default "controller" .Values.controller.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.controller.serviceAccount.name }}
{{- end }}
{{- end }}
