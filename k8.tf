resource "digitalocean_kubernetes_cluster" "ryu_staging" {
  name          = "ryu-staging-cluster"
  region        = var.do_region
  auto_upgrade  = false
  surge_upgrade = true
  vpc_uuid      = digitalocean_vpc.staging.id
  version       = data.digitalocean_kubernetes_versions.default.latest_version

  tags = ["staging"]

  node_pool {
    name       = "worker-pool-staging"
    size       = "s-2vcpu-2gb"
    auto_scale = false
    tags       = ["staging", "app"]
    node_count = 2
  }

}
