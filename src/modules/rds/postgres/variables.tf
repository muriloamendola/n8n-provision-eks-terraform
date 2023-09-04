variable "common_tags" {
  description = "Common tags to be associted to resources"
  type = object({
    business_division = string
    environment       = string
  })
}

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC Id"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

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

variable "rds_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = true
}

variable "rds_port" {
  description = "Port that will be exposed and allow access to database"
  type        = number
  default     = 5432
}

variable "allocated_storage" {
  description = "The amount of allocated storage."
  type        = number
  default     = 20
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
}

variable "postgres_database" {
  description = "The database name that will be created"
  type        = string
}

variable "postgres_username" {
  description = "Master db user username"
  type        = string
}

variable "postgres_password" {
  description = "Master db user password"
  type        = string
}
