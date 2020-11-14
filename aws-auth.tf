variable "aws_auth_node_role_arns" {
  description = "ARNs of node group roles"
  type        = list(string)
  default     = []
}

data "template_file" "aws_auth_role" {
  template = file("${path.module}/templates/aws-auth-role.yaml")
  count    = length(var.aws_auth_node_role_arns)
  vars = {
    role_arn = element(var.aws_auth_node_role_arns, count.index)
  }
}

data "template_file" "aws_auth" {
  template = file("${path.module}/templates/aws-auth.yaml")

  vars = {
    role_map = join("\n", data.template_file.aws_auth_role.*.rendered)
  }
}

resource "local_file" "aws_auth" {
  sensitive_content = data.template_file.aws_auth.rendered
  filename          = "${path.root}/.kube/aws-auth.yaml"

  provisioner "local-exec" {
    command = "chmod -x,o=,g= ${path.root}/.kube/aws-auth.yaml"
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "null_resource" "aws_auth" {
  triggers = {
    kubecfg  = base64sha256(local_file.kubecfg.sensitive_content)
    aws_auth = base64sha256(local_file.aws_auth.sensitive_content)
  }

  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/.kube/config"
    }

    command = "kubectl version"
  }

  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/.kube/config"
    }

    command = "kubectl apply -f ${path.root}/.kube/aws-auth.yaml"
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    local_file.kubecfg,
    local_file.aws_auth,
  ]
}

output "config_map_aws_auth" {
  description = "A kubernetes configuration to authenticate to this EKS cluster."
  value       = data.template_file.aws_auth.rendered
}

