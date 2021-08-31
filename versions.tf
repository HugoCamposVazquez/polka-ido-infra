terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "1.13.3"
    }
  }
  required_version = ">= 0.13"
}

data "digitalocean_kubernetes_versions" "default" {
  version_prefix = "1.20"
}