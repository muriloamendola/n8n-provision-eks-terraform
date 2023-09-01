resource "kubernetes_service" "n8n_service" {
  depends_on = [ module.eks ]

  metadata {
    name      = "n8n"
    namespace = kubernetes_namespace.environment_namespace.metadata.0.name
    labels = {
      app = "n8n"
    }
  }
  spec {
    selector = {
      app = "n8n"
    }
    port {
      name        = "5678"
      port        = 5678
      protocol    = "TCP"
      target_port = 5678
    }
  }
}
