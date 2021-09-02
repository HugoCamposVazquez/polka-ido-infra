resource "kubernetes_persistent_volume_claim" "ryu_staging_db" {
  metadata {
    name = "ryu-db-staging-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "do-block-storage"
  }
}

resource "kubernetes_secret" "ryu_db_credentials" {
  metadata {
    name = "ryu-db-credentials"
  }

  data = {
    postgresql-postgres-password = "RYU123!"
    postgresql-password          = "RYU123!"
  }

  type = "Opaque"

  lifecycle {
    //only set password when creating
    ignore_changes = [data]
  }
}

resource "helm_release" "ryu_db_staging" {
  name       = "ryu-database"
  chart      = "postgresql"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  version    = "10.9.4"

  depends_on = [
    kubernetes_persistent_volume_claim.ryu_staging_db
  ]

  values = [
    file("${path.module}/database.yaml")
  ]
  set {
    name  = "existingSecret"
    value = kubernetes_secret.ryu_db_credentials.metadata.0.name
    type  = "string"
  }

  set {
    name  = "postgresqlUsername"
    value = "ryu-backend"
    type  = "string"
  }

  set {
    name  = "postgresqlDatabase"
    value = "ryu"
    type  = "string"
  }

  set {
    name  = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.ryu_staging_db.metadata.0.name
    type  = "string"
  }

  set {
    name  = "volumePermissions.enabled"
    value = "true"
  }

}

resource "kubernetes_secret" "ryu_db" {
  metadata {
    name = "ryu-backend-db"
  }

  data = {
    private_host = "ryu-database-postgresql.default.svc.cluster.local"
    host         = ""
    port         = "5432"
    uri          = ""
    private_uri  = ""
    db_name      = "ryu"
    username     = "ryu-backend"
    password     = "RYU123!"
  }

  type = "Opaque"
}