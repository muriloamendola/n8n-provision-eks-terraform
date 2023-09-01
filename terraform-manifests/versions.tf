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
      source = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }

    # To deploy Services, Deployments and other resources to kubernetes
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.11.0"
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

provider "kubernetes" {
  config_path = var.kubernetes_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubernetes_config_path
  }
}
