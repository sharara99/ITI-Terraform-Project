#Create an S3 bucket resource
resource "aws_s3_bucket" "bucket1" {
 bucket = "terraform-project-sharara"

 force_destroy       = true
 object_lock_enabled = false

 tags = {
   Name        = "terraform-project-sharara"
   Environment = var.Environment
   Owner       = var.Owner
 }
}
