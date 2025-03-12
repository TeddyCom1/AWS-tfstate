resource "aws_s3_bucket" "tfstate_bucket" {
    bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
    bucket = aws_s3_bucket.tfstate_bucket.id
    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_encryption" {
    bucket = aws_s3_bucket.tfstate_bucket.id
    rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_object_lock_configuration" "tfstate_objectlock" {
    depends_on = [ aws_s3_bucket_versioning.tfstate_versioning ]
    bucket = aws_s3_bucket.tfstate_bucket.id
    object_lock_enabled = "Enabled"
}