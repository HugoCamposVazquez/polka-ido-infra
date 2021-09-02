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

data "digitalocean_kubernetes_cluster" "default" {
  name = var.k8_cluster_name
}

provider "helm" {
  kubernetes {
    host  = data.digitalocean_kubernetes_cluster.default.kube_config.0.host
    token = data.digitalocean_kubernetes_cluster.default.kube_config.0.token

    client_certificate     = base64decode(data.digitalocean_kubernetes_cluster.default.kube_config.0.client_certificate)
    client_key             = base64decode(data.digitalocean_kubernetes_cluster.default.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.default.kube_config.0.host
  token = data.digitalocean_kubernetes_cluster.default.kube_config.0.token

  client_certificate     = base64decode(data.digitalocean_kubernetes_cluster.default.kube_config.0.client_certificate)
  client_key             = base64decode(data.digitalocean_kubernetes_cluster.default.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate)
}