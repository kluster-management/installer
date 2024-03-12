{{/*
Expand the name of the chart.
*/}}
{{- define "managed-serviceaccount-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "managed-serviceaccount-manager.fullname" -}}
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
{{- define "managed-serviceaccount-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "managed-serviceaccount-manager.labels" -}}
helm.sh/chart: {{ include "managed-serviceaccount-manager.chart" . }}
{{ include "managed-serviceaccount-manager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "managed-serviceaccount-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "managed-serviceaccount-manager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Addon manager namespace
*/}}
{{- define "managed-serviceaccount-manager.namespace" -}}
{{ ternary .Release.Namespace (required "A valid .Values.addonManagerNamespace is required!" .Values.addonManagerNamespace) (empty .Values.kubeconfigSecretName) }}
{{- end }}
