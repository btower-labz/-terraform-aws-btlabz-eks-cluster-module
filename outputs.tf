output "cluster_name" {
  description = "The name of the cluster."
  value       = aws_eks_cluster.eks_cluster.id
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = aws_eks_cluster.eks_cluster.arn
}

output "cluster_endpoint" {
  description = "The endpoint for your Kubernetes API server."
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_k8s_version" {
  description = "The K8S version for the cluster"
  value       = aws_eks_cluster.eks_cluster.version
}

output "cluster_platform_version" {
  description = "The AWS EKS Platform Version"
  value       = aws_eks_cluster.eks_cluster.platform_version
}

output "cluster_k8s_auth" {
  description = "The base64 encoded certificate data required to communicate with your cluster."
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  sensitive   = true
}

output "control_plane_role_name" {
  description = "Control plane role name."
  value       = aws_iam_role.iam_role_eks_cluster.name
}

output "control_plane_role_arn" {
  description = "Control plane role ARN."
  value       = aws_iam_role.iam_role_eks_cluster.arn
}
