resource "kubernetes_deployment" "n8n_deployment" {

  depends_on = [ module.eks, kubernetes_persistent_volume_claim.n8n_claim0 ]

  metadata {
    name = "n8n"
    namespace = kubernetes_namespace.environment_namespace.metadata.0.name
    labels = {
      app = "n8n"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "n8n"
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = {
          app = "n8n"
        }
      }

      spec {
        init_container {
          name = "volume-permissions"
          image = "busybox:1.36"
          command = [ "sh", "-c", "chown 1000:1000 /data" ]
          volume_mount {
            name = "n8n-claim0"
            mount_path = "/data"
          }
        }

        restart_policy = "Always"
        
        volume {
          name = "n8n-claim0"
          persistent_volume_claim {
            claim_name = "n8n-claim0"
          }
        }

        container {
          image = "n8nio/n8n"
          name = "n8n"
          command = [ "/bin/sh", "-c", "sleep 5; n8n start" ]
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
            name = "n8n-claim0"
            mount_path = "/home/node/.n8n"
          }
          
          env {
            name = "DB_TYPE"
            value = "postgresdb"
          }
          env {
            name = "DB_POSTGRESDB_HOST"
            value = ""
          }
          env {
            name = "DB_POSTGRESDB_PORT"
            value = "5432"
          }
          env {
            name = "DB_POSTGRESDB_DATABASE"
            value = "n8n"
          }
          env {
            name = "DB_POSTGRESDB_USER"
            value = "admin"
          }
          env {
            name = "DB_POSTGRESDB_PASSWORD"
            value = "admin"
          }
          env {
            name = "N8N_PROTOCOL"
            value = "http"
          } 
          env {
            name = "N8N_PORT"
            value = "5678"
          } 
        }
      }
    }
  }
}