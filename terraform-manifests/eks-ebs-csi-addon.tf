resource "aws_eks_addon" "ebs-csi" {
  addon_name    = "aws-ebs-csi-driver"
  addon_version = "v1.20.0-eksbuild.1"

  cluster_name             = module.eks.cluster_name
  service_account_role_arn = module.irsa-ebs-csi.iam_role_arn
  tags = merge(local.common_tags, {
    "eks_addon" = "ebs-csi"
  })
}