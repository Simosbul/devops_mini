resource "aws_vpc" "devops_mini" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devops-mini-vpc"
  }
}