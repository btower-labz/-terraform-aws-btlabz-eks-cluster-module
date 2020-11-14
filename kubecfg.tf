variable "k8s_iam_auth_profile" {
  description = "AWS CLI profile to use in kubecfg for authentication"
  default     = "default"
}

resource "local_file" "kubecfg" {
  sensitive_content = data.template_file.kubecfg.rendered
  filename          = "${path.root}/.kube/config"

  provisioner "local-exec" {
    command = "chmod -x,o=,g= ${path.root}/.kube/config"
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

data "template_file" "kubecfg" {
  template = file("${path.module}/templates/kubecfg-token.yaml")

  vars = {
    name     = aws_eks_cluster.eks_cluster.id
    endpoint = aws_eks_cluster.eks_cluster.endpoint
    auth     = aws_eks_cluster.eks_cluster.certificate_authority[0].data
    profile  = var.k8s_iam_auth_profile
    region   = data.aws_region.current.name
  }
}

output "kubecfg" {
  description = "Cluster's kubeconfig (reference sample, token auth)."
  value       = data.template_file.kubecfg.rendered
  sensitive   = true
}


