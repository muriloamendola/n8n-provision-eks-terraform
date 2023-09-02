module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.1"

  identifier = local.rds_identifier

  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  family               = var.rds_family
  major_engine_version = var.rds_engine_version
  instance_class       = var.rds_intance_class
  publicly_accessible  = var.rds_publicly_accessible

  allocated_storage = var.allocated_storage

  db_name  = var.postgres_database
  username = var.postgres_username
  port     = var.rds_port

  manage_master_user_password = false
  password                    = var.postgres_password # Do not use this approach in production environment

  multi_az               = true
  db_subnet_group_name   = module.vpc.database_subnet_group
  subnet_ids             = module.vpc.database_subnets
  vpc_security_group_ids = [module.rds_sg.security_group_id]

  tags = local.common_tags
}