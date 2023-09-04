provider "aws" {
  region = var.aws_region

  # Instead of using profile attribute, we could use access and secret keys from an IAM user
  # access_key = var.access_key
  # secret_key = var.secret_key

  profile = var.aws_profile
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name    = "${local.resource_name_prefix}-vpc"
  common_tags = local.common_tags
}

locals {
  cluster_name = "${local.resource_name_prefix}-cluster"
}

module "eks" {
  source = "../../modules/eks"

  cluster_name = local.cluster_name
  common_tags  = local.common_tags

  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
}

module "rds_postgres" {
  source = "../../modules/rds/postgres"

  depends_on = [module.vpc]

  identifier = "${local.resource_name_prefix}-n8n-postgres"

  vpc_id               = module.vpc.vpc_id
  vpc_cidr_block       = module.vpc.vpc_cidr_block
  db_subnet_group_name = module.vpc.database_subnet_group
  subnet_ids           = module.vpc.database_subnets

  # postgres settings
  postgres_database = var.postgres_database
  postgres_username = var.postgres_username
  postgres_password = var.postgres_password

  common_tags = local.common_tags
}

# Kubernetes configuration 
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--profile", var.aws_profile, "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

resource "kubernetes_namespace" "environment_namespace" {
  depends_on = [module.eks]

  metadata {
    labels = {
      app = module.eks.cluster_name
    }
    name = var.environment
  }
}

# Applications
module "n8n" {
  source = "../../applications/n8n"

  depends_on = [module.eks, module.rds_postgres]

  namespace = kubernetes_namespace.environment_namespace.metadata.0.name

  # postgres settings
  postgres_host     = module.rds_postgres.db_instance_address
  postgres_database = var.postgres_database
  postgres_username = var.postgres_username
  postgres_password = var.postgres_password
}