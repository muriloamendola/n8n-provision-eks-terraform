resource "kubernetes_service" "n8n_service" {
  metadata {
    name      = var.n8n_deployment_and_service_name
    namespace = var.namespace
    labels = {
      app = var.n8n_deployment_and_service_name
    }
  }
  spec {
    type = var.service_spec_type
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
