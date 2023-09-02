variable "rds_engine" {
  description = "Which db engine we will use to create rds intance"
  type        = string
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "Postgres version"
  type        = string
  default     = "14"
}

variable "rds_family" {
  description = "RDS family"
  type        = string
  default     = "postgres14"
}

variable "rds_intance_class" {
  description = "EC2 intance type to support rds db engine"
  type        = string
  default     = "db.t4g.micro"
}

variable "rds_port" {
  description = "Port that will be exposed and allow access to database"
  type        = number
  default     = 5432
}

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
  default     = "admin"
}

variable "allocated_storage" {
  description = "The amount of allocated storage."
  type        = number
  default     = 20
}