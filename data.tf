data "aws_region" "current" {}

data "aws_subnet" "main" {
  id = element(sort(compact(var.subnets)), 0)
}

data "aws_vpc" "main" {
  id = data.aws_subnet.main.vpc_id
}

data "aws_iam_policy_document" "cluster_assume_role_policy" {
  statement {
    sid = "EKSClusterAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ec2_trust" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "kube2iam" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = var.kube2iam_roles
  }
}
