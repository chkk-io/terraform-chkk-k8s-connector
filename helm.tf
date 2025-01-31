resource "helm_release" "chkk_operator" {
  depends_on = [kubectl_manifest.crds]

  name             = var.release_name
  repository       = "https://helm.chkk.io"
  chart            = "chkk-operator"
  version          = var.chart_version != "" ? var.chart_version : null
  namespace        = var.namespace
  create_namespace = var.create_namespace

  values = [
    yamlencode(var.chkk_operator_config)
  ]
}
