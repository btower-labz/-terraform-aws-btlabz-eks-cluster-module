resource "aws_security_group" "cluster" {
  name        = "${var.cluster_name}-eks-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = data.aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-eks-cluster-sg"
    #Stack       = local.stack
    #Environment = local.environment
    #Origin      = local.origin
  }
}

#resource "aws_security_group_rule" "cluster-ingress-node-https" {
#  description              = "Allow pods to communicate with the cluster API Server"
#  from_port                = 443
#  protocol                 = "tcp"
#  security_group_id        = aws_security_group.cluster.id
#  source_security_group_id = aws_security_group.node.id
#  to_port                  = 443
#  type                     = "ingress"
#}
