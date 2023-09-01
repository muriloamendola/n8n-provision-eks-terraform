variable "n8n_deployment_and_service_name" {
  description = "Name for the deployment and for service which will run n8n"
  type = string
  default = "n8n"
}

variable "claim0_persistent_volume_name" {
  description = "The name of persistent volume where n8n will store secrets"
  type = string
  default = "n8n-claim0"
}

variable "n8n_protocol" {
  description = "n8n protocol to be used"
  type = string
  default = "http"
}

variable "n8n_port" {
  description = "n8n port to be exposed"
  type = string
  default = "5678"
}