variable "cluster_version" {
  description = "The version of EKS Cluster"
  type        = string
  default     = "1.27"
}

variable "managed_node_group_ami_type" {
  description = "Non-GPU instances should use the AL2_x86_64 AMI type, which uses the Amazon EKS-optimized Linux AMI."
  type        = string
  default     = "AL2_x86_64"
}

variable "managed_node_groups" {
  description = "Configurations for EKS managed node groups"
  type = map(object({
    name           = string
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
  }))
  default = {
    one = {
      name           = "node-group-1"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    },

    two = {
      name           = "node-group-2"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }
}