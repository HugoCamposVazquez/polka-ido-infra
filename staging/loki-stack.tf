resource "helm_release" "loki_stack_staging" {
  name             = "loki-stack"
  chart            = "loki-stack"
  namespace        = "loki-stack"
  create_namespace = true
  repository       = "https://grafana.github.io/helm-charts"
  version          = "2.3.1"

  values = [
    file("${path.module}/loki-stack.yaml")
  ]
}