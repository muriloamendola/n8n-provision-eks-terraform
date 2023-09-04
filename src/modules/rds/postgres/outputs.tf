output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.rds.db_instance_address
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.rds_postgres_sg.security_group_id
}