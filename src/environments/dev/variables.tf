variable "aws_region" {
  description = "Region in which AWS Resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Defines which profile credential inside $HOME/.aws/credentials terraform must use to connect to AWS account"
  type        = string
  default     = "personal"
}

variable "environment" {
  description = "Environment Variable used as a prefix for resources name"
  type        = string
  default     = "dev"
}

variable "business_division" {
  description = "Define who is the owner of the resources. It is useful for split billing and organizing resources"
  type        = string
  default     = "technology"
}

# Database settings 
variable "postgres_database" {
  description = "The database name that will be created"
  type        = string
  default     = "n8n"
}

variable "postgres_username" {
  description = "Master db user username"
  type        = string
  default     = "n8n_administrator"
}

variable "postgres_password" {
  description = "Master db user password"
  type        = string
  default     = "n8nadmin"
}

# EKS settings
variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}