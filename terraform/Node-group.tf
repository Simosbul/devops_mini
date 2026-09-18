resource "aws_eks_node_group" "devops_mini" {
  cluster_name    = aws_eks_cluster.devops_mini.name
  node_group_name = "devops-mini-nodes"
  node_role_arn   = aws_iam_role.eks_node.arn

  subnet_ids = [
    aws_subnet.devops_mini_private_1.id,
    aws_subnet.devops_mini_private_2.id
  ]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  instance_types = ["t3.small"]

  depends_on = [
    aws_eip.devops_mini_nat,
    aws_nat_gateway.devops_mini,
    aws_route_table.devops_mini_private,
    aws_route_table_association.devops_mini_private_1,
    aws_route_table_association.devops_mini_private_2
  ]
}
