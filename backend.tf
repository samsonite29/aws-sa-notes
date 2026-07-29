terraform {
  backend "s3" {
    bucket         = "sa-lab-terraform-state-a15f0c2e"
    key            = "aws-sa-labs/infrastructure/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}