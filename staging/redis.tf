
resource "helm_release" "ryu_redis_staging" {
  name       = "ryu-redis"
  chart      = "redis"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  version    = "15.3.0"

  values = [
    file("${path.module}/redis.yaml")
  ]
}
