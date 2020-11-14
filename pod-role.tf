data "aws_iam_policy_document" "pod_trust" {
  statement {
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.main.arn
      ]
    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.main.url, "https://", "")}:sub"
      values   = [
        "system:serviceaccount:kube-system:aws-node"
      ]
    }

  }
}

resource "aws_iam_role" "pod_role" {
  assume_role_policy = data.aws_iam_policy_document.pod_trust.json
  name               = "example"
}
