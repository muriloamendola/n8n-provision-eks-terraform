# Namespace

resource "kubernetes_namespace" "environment_namespace" {
  metadata {
    labels = {
      app = local.name
    }
    name = local.environment
  }
}
