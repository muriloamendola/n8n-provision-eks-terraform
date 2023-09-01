resource "kubernetes_persistent_volume_claim" "n8n_claim0" {
  depends_on = [ module.eks ]

  metadata {
    name = "n8n-claim0"
    namespace = kubernetes_namespace.environment_namespace.metadata.0.name

    labels = {
      app = "n8n-claim0"
    }
  }

  spec {
    resources {
      requests = {
        storage = "2Gi"
      }
    }

    access_modes = ["ReadWriteOnce"]
  }
}
