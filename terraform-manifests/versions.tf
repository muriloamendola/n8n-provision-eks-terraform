# Terraform Block
terraform {
  required_version = "~> 1.5.5" # which means any version equal & above 1.5.5 and < 1.6.0

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.14.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }

    # To deploy Services, Deployments and other resources to kubernetes
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
  }

  # Not recommended for production environment. See https://developer.hashicorp.com/terraform/language/state/remote
  backend "local" {
    path = ".state/terraform.tfstate"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# Kubernetes provider configuration 
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--profile", var.aws_profile, "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

