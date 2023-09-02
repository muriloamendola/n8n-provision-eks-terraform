output "security_group_id" {
  description = "The ID of the security group"
  value       = module.rds_sg.security_group_id
}