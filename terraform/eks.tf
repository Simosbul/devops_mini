resource "aws_eks_cluster" "devops_mini" {
  name     = "devops-mini"
  role_arn = aws_iam_role.eks_cluster.arn

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids = [
      aws_subnet.devops_mini_private_1.id,
      aws_subnet.devops_mini_private_2.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster
  ]
}

resource "aws_eks_access_entry" "github_actions" {
  cluster_name  = aws_eks_cluster.devops_mini.name
  principal_arn = aws_iam_role.github_actions.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "github_actions" {
  cluster_name  = aws_eks_cluster.devops_mini.name
  principal_arn = aws_iam_role.github_actions.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"

  access_scope {
    type = "cluster"

  }

  depends_on = [
  aws_eks_access_entry.github_actions]


}
