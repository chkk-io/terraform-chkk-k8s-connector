resource "kubectl_manifest" "crds" {
  yaml_body = file("${path.module}/crds.yaml")
}
