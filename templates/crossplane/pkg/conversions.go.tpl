{{ template "boilerplate" }}

// Code generated by ack-generate. DO NOT EDIT.

package {{ .CRD.Names.Lower }}

import (
{{- if .CRD.TypeImports }}
{{- range $packagePath, $alias := .CRD.TypeImports }}
	{{ if $alias }}{{ $alias }} {{ end }}"{{ $packagePath }}"
{{ end }}
{{- end }}
	"github.com/aws/aws-sdk-go/aws/awserr"
	svcsdk "github.com/aws/aws-sdk-go/service/{{ .ServiceIDClean }}"

	awsclients "github.com/crossplane/provider-aws/pkg/clients"
	svcapitypes "github.com/crossplane/provider-aws/apis/{{ .ServiceIDClean }}/{{ .APIVersion}}"
)

{{ if .CRD.Ops.ReadOne }}
    {{- template "sdk_find_read_one" . }}
{{- else if .CRD.Ops.GetAttributes }}
    {{- template "sdk_find_get_attributes" . }}
{{- else if .CRD.Ops.ReadMany }}
    {{- template "sdk_find_read_many" . }}
{{- end }}

// Generate{{ .CRD.Ops.Create.InputRef.Shape.ShapeName }} returns a create input.
func Generate{{ .CRD.Ops.Create.InputRef.Shape.ShapeName }}(cr *svcapitypes.{{ .CRD.Names.Camel }}) *svcsdk.{{ .CRD.Ops.Create.InputRef.Shape.ShapeName }} {
	res := &svcsdk.{{ .CRD.Ops.Create.InputRef.Shape.ShapeName }}{}
{{ GoCodeSetCreateInput .CRD "cr" "res" 1 }}
	return res
}
{{ if .CRD.Ops.Update -}}
// Generate{{ .CRD.Ops.Update.InputRef.Shape.ShapeName }} returns an update input.
func Generate{{ .CRD.Ops.Update.InputRef.Shape.ShapeName }}(cr *svcapitypes.{{ .CRD.Names.Camel }}) *svcsdk.{{ .CRD.Ops.Update.InputRef.Shape.ShapeName }} {
	res := &svcsdk.{{ .CRD.Ops.Update.InputRef.Shape.ShapeName }}{}
{{ GoCodeSetUpdateInput .CRD "cr" "res" 1 }}
	return res
}
{{- end}}

{{ if .CRD.Ops.Delete -}}
// Generate{{ .CRD.Ops.Delete.InputRef.Shape.ShapeName }} returns a deletion input.
func Generate{{ .CRD.Ops.Delete.InputRef.Shape.ShapeName }}(cr *svcapitypes.{{ .CRD.Names.Camel }}) *svcsdk.{{ .CRD.Ops.Delete.InputRef.Shape.ShapeName }} {
	res := &svcsdk.{{ .CRD.Ops.Delete.InputRef.Shape.ShapeName }}{}
{{ GoCodeSetDeleteInput .CRD "cr" "res" 1 }}
	return res
}
{{ end }}
// IsNotFound returns whether the given error is of type NotFound or not.
func IsNotFound(err error) bool {
	awsErr, ok := err.(awserr.Error)
	return ok && awsErr.Code() == "{{ ResourceExceptionCode .CRD 404 }}" {{ GoCodeSetExceptionMessagePrefixCheck .CRD 404 }}
}