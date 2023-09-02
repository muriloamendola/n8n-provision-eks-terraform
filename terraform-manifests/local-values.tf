locals {
  owners      = var.business_divsion
  environment = var.environment
  name        = "${var.business_divsion}-${var.environment}"

  common_tags = {
    owners      = local.owners
    environment = local.environment
  }

  # EKS locals because we can't use variables inside variable block
  cluster_name = "${local.name}-n8n-cluster"

  # RDS locals
  rds_identifier = "${local.name}-n8n-${var.rds_engine}"
} 