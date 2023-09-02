# Namespace

resource "kubernetes_namespace" "environment_namespace" {
  depends_on = [module.eks]

  metadata {
    labels = {
      app = local.cluster_name
    }
    name = local.environment
  }
}
