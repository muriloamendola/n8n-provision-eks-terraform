resource "kubernetes_service" "n8n_service" {
  depends_on = [module.eks]

  metadata {
    name      = var.n8n_deployment_and_service_name
    namespace = kubernetes_namespace.environment_namespace.metadata.0.name
    labels = {
      app = var.n8n_deployment_and_service_name
    }
  }
  spec {
    selector = {
      app = var.n8n_deployment_and_service_name
    }
    port {
      name        = var.n8n_port
      port        = var.n8n_port
      protocol    = "TCP"
      target_port = var.n8n_port
    }
  }
}
