{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus.name" -}}
{{- default .Chart.Name .Values.prometheus.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "monitoring.labels.selector-prom" -}}
app: {{ template "prometheus.name" . }}-prometheus
{{ template "monitoring.prometheus.labels.groupAndProvider" . }}
{{- end -}}

{{- define "monitoring.prometheus.labels.groupAndProvider" -}}
group: {{ .Values.prometheus.labels.group }}
provider: {{ .Values.prometheus.labels.provider }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prometheus.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

#{{- define "prometheus.labels.selector" -}}
#app: {{ template "prometheus.name" . }}
#group: {{ .Values.prometheus.labels.group }}
#provider: {{ .Values.prometheus.labels.provider }}
#{{- end -}}

{{- define "prometheus.labels.stakater" -}}
{{ template "monitoring.labels.selector-prom" . }}
version: "{{ .Values.prometheus.labels.version }}"
{{- end -}}

{{- define "prometheus.labels.chart" -}}
chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
release: {{ .Release.Name | quote }}
heritage: {{ .Release.Service | quote }}
{{- end -}}
