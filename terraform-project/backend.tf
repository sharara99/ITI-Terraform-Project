terraform {
  backend "s3" {
    bucket = "terraform-project-sharara"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}