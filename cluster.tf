resource "aws_eks_cluster" "eks_cluster" {

  name     = var.cluster_name
  role_arn = aws_iam_role.iam_role_eks_cluster.arn
  version  = var.k8s_version

  enabled_cluster_log_types = var.enabled_cluster_log_types

  # TODO: HardCode
  vpc_config {

    endpoint_private_access = true
    endpoint_public_access  = true

    public_access_cidrs = [
      "0.0.0.0/0"
    ]

    security_group_ids = [aws_security_group.cluster.id]

    subnet_ids = var.subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.policy_attachment_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.policy_attachment_AmazonEKSServicePolicy,
  ]

  tags = merge(
    map(
      "Name", var.cluster_name
    ),
    var.tags
  )

}
