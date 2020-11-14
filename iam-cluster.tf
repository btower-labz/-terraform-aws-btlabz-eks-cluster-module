resource "aws_iam_role" "iam_role_eks_cluster" {
  name               = "${var.cluster_name}-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role_policy.json

  tags = {
    Name = "${var.cluster_name}-eks-cluster-role"
    #Stack       = local.stack
    #Environment = local.environment
    #Origin      = local.origin
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role_eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "policy_attachment_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.iam_role_eks_cluster.name
}

