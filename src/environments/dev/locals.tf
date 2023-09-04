locals {
  business_division    = var.business_division
  environment          = var.environment
  resource_name_prefix = "${var.business_division}-${var.environment}"

  common_tags = {
    business_division = local.business_division
    environment       = local.environment
  }
} 