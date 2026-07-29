terraform {
  backend "s3" {
    bucket         = "sa-lab-terraform-state-151d5ba5"
    key            = "infrastructure/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}