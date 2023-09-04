module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.1"

  identifier = var.identifier

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

  multi_az               = var.multi_az
  db_subnet_group_name   = var.db_subnet_group_name
  subnet_ids             = var.subnet_ids
  vpc_security_group_ids = [module.rds_postgres_sg.security_group_id]

  tags = var.common_tags
}