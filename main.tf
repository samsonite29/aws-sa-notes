provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Environment = "lab"
      Project     = "aws-sa-labs"
      ManagedBy   = "terraform"
      Owner       = "samson"
    }
  }
}

provider "aws" {
  alias  = "dr"
  region = "eu-north-1"
}