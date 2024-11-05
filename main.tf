resource "random_id" "random" {
  byte_length = 8
}

locals {
  stack_name = "test-playground-terraform-s3-versions-${random_id.random.dec}"
}

resource "aws_s3_bucket" "example" {
  bucket = local.stack_name
  tags = {
    Name        = "stackName"
    Environment = local.stack_name
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "file_upload" {
  bucket = aws_s3_bucket.example.bucket
  key    = "first_file.txt"
  source = "${path.module}/data/first_file.txt"

  etag = filemd5("${path.module}/data/first_file.txt")
}

resource "aws_s3_object" "file_upload_without_etag" {
  bucket = aws_s3_bucket.example.bucket
  key    = "first_file_without_etag.txt"
  source = "${path.module}/data/first_file.txt"
}

output "s3_version" {
  value = aws_s3_object.file_upload.version_id
}