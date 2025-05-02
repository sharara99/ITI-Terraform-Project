# main.tf placeholder
resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-project-sharara"

  force_destroy = true

  tags = {
    Name        = "terraform-project-sharara"
    Environment = var.Environment
    Owner       = var.Owner
  }
}
