resource "aws_s3_bucket" "devops_mini" {
  bucket        = "devops-mini-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
}

data "aws_caller_identity" "current" {}