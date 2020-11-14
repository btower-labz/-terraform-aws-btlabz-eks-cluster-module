# See: https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
# See: https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html
# See: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# See: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider

data "tls_certificate" "openid_connect" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "main" {
  client_id_list = [
    "sts.amazonaws.com"
  ]
  thumbprint_list = [
    data.tls_certificate.openid_connect.certificates[0].sha1_fingerprint
  ]
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "openid_provider_arn" {
  value = aws_iam_openid_connect_provider.main.arn
}

output "openid_provider_url" {
  value = aws_iam_openid_connect_provider.main.url
}
