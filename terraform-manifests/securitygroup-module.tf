# Security Group for AWS RDS DB
module "rds_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  depends_on = [module.vpc]

  name        = "${local.rds_identifier}-sg"
  description = "Access to Postgres DB for entire VPC CIDR Block"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = var.rds_port
      to_port     = var.rds_port
      protocol    = "tcp"
      description = "Postgres access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]

  tags = local.common_tags
}