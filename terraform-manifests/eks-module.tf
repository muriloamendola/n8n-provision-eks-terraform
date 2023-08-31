module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name = local.cluster_name
  cluster_version = var.cluster_version

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = var.managed_node_group_ami_type
  }

  eks_managed_node_groups = var.managed_node_groups
}