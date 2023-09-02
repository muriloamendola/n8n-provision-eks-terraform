variable "aws_region" {
  description = "Region in which AWS Resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Defines which profile credential inside $HOME/.aws/credentials terraform must use to connect to AWS account"
  type        = string
  default     = "personal"
}

variable "environment" {
  description = "Environment Variable used as a prefix for resources name"
  type        = string
  default     = "dev"
}

variable "business_divsion" {
  description = "Define who is the owner of the resources. It is useful for split billing and organizing resources"
  type        = string
  default     = "technology"
}
