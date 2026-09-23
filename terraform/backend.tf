terraform {
  backend "s3" {
    bucket = "devops-mini-980819806634"
    key    = "terraform/terraform.tfstate"
    region = "eu-north-1"
    use_lockfile = true
  }
}

resource "aws_s3_bucket" "devops_sim_bucket" {
  bucket = "devops-sim-980819806634-test"

  tags = {
    Environment = "test"
  }
}