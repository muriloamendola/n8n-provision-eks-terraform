resource "kubernetes_persistent_volume_claim" "n8n_claim0" {
  metadata {
    name      = var.claim0_persistent_volume_name
    namespace = var.namespace

    labels = {
      app = var.claim0_persistent_volume_name
    }
  }

  spec {
    resources {
      requests = {
        storage = var.pv_storage
      }
    }

    access_modes = var.pv_access_modes
  }
}
