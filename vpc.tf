resource "digitalocean_vpc" "staging" {
  name     = "ryu-staging-vpc"
  region   = var.do_region
  ip_range = "10.11.12.0/24"
}