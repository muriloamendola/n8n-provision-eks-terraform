resource "kubernetes_deployment" "n8n_deployment" {

  depends_on = [module.eks, module.rds]

  metadata {
    name      = var.n8n_deployment_and_service_name
    namespace = kubernetes_namespace.environment_namespace.metadata.0.name
    labels = {
      app = var.n8n_deployment_and_service_name
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.n8n_deployment_and_service_name
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = {
          app = var.n8n_deployment_and_service_name
        }
      }

      spec {
        init_container {
          name    = "volume-permissions"
          image   = "busybox:1.36"
          command = ["sh", "-c", "chown 1000:1000 /data"]
          volume_mount {
            name       = var.claim0_persistent_volume_name
            mount_path = "/data"
          }
        }

        restart_policy = "Always"

        volume {
          name = var.claim0_persistent_volume_name
          persistent_volume_claim {
            claim_name = var.claim0_persistent_volume_name
          }
        }

        container {
          image   = "n8nio/n8n"
          name    = var.n8n_deployment_and_service_name
          command = ["/bin/sh", "-c", "sleep 5; n8n start"]
          port {
            container_port = 5678
          }
          resources {
            requests = {
              memory = "250Mi"
            }
            limits = {
              memory = "500Mi"
            }
          }
          volume_mount {
            name       = var.claim0_persistent_volume_name
            mount_path = "/home/node/.n8n"
          }

          env {
            name  = "DB_TYPE"
            value = "postgresdb"
          }
          env {
            name  = "DB_POSTGRESDB_HOST"
            value = module.rds.db_instance_address
          }
          env {
            name  = "DB_POSTGRESDB_PORT"
            value = var.rds_port
          }
          env {
            name  = "DB_POSTGRESDB_DATABASE"
            value = var.postgres_database
          }
          env {
            name  = "DB_POSTGRESDB_USER"
            value = var.postgres_username
          }
          env {
            name  = "DB_POSTGRESDB_PASSWORD"
            value = var.postgres_password
          }
          env {
            name  = "N8N_PROTOCOL"
            value = var.n8n_protocol
          }
          env {
            name  = "N8N_PORT"
            value = var.n8n_port
          }
        }
      }
    }
  }
}