resource "kubectl_manifest" "chkkagent" {
  depends_on = [helm_release.chkk_operator]
  yaml_body = templatefile("${path.module}/chkkagent.tftpl", {
    namespace         = helm_release.chkk_operator.namespace
    filter            = var.filter
    chkk_agent_config = var.chkk_agent_config
  })
}

