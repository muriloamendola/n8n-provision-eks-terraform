resource "kubernetes_persistent_volume_claim" "n8n_claim0" {
  depends_on = [ module.eks ]

  metadata {
    name = var.claim0_persistent_volume_name
    namespace = kubernetes_namespace.environment_namespace.metadata.0.name

    labels = {
      app = var.claim0_persistent_volume_name
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
