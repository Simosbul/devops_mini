resource "aws_eks_cluster" "devops_mini" {
  name     = "devops-mini"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.devops_mini_private_1.id,
      aws_subnet.devops_mini_private_2.id
    ]
  }
}