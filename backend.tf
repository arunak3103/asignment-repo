terraform {
  backend "s3" {
    bucket = "devops-tf-state-as"
    key = "qa/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}


