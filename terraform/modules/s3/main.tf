# S3 Buckets for ETL Pipeline

# Raw Zone Bucket
resource "aws_s3_bucket" "raw" {
  bucket = "${var.project_name}-${var.environment}-raw-zone"

  tags = {
    Name        = "${var.project_name}-${var.environment}-raw-zone"
    Environment = var.environment
    Zone        = "raw"
  }
}

# Enable versioning for raw bucket
resource "aws_s3_bucket_versioning" "raw" {
  bucket = aws_s3_bucket.raw.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption for raw bucket (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "raw" {
  bucket = aws_s3_bucket.raw.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Lifecycle policy for raw bucket (90-day retention)
resource "aws_s3_bucket_lifecycle_configuration" "raw" {
  bucket = aws_s3_bucket.raw.id

  rule {
    id     = "expire-old-raw-data"
    status = "Enabled"

    filter {}

    expiration {
      days = var.raw_retention_days
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

# Block public access for raw bucket
resource "aws_s3_bucket_public_access_block" "raw" {
  bucket = aws_s3_bucket.raw.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Curated Zone Bucket
resource "aws_s3_bucket" "curated" {
  bucket = "${var.project_name}-${var.environment}-curated-zone"

  tags = {
    Name        = "${var.project_name}-${var.environment}-curated-zone"
    Environment = var.environment
    Zone        = "curated"
  }
}

# Enable versioning for curated bucket
resource "aws_s3_bucket_versioning" "curated" {
  bucket = aws_s3_bucket.curated.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption for curated bucket (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "curated" {
  bucket = aws_s3_bucket.curated.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access for curated bucket
resource "aws_s3_bucket_public_access_block" "curated" {
  bucket = aws_s3_bucket.curated.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Query Results Bucket
resource "aws_s3_bucket" "query_results" {
  bucket = "${var.project_name}-${var.environment}-query-results"

  tags = {
    Name        = "${var.project_name}-${var.environment}-query-results"
    Environment = var.environment
    Purpose     = "athena-query-results"
  }
}

# Server-side encryption for query results bucket (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "query_results" {
  bucket = aws_s3_bucket.query_results.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Lifecycle policy for query results bucket (7-day deletion)
resource "aws_s3_bucket_lifecycle_configuration" "query_results" {
  bucket = aws_s3_bucket.query_results.id

  rule {
    id     = "expire-query-results"
    status = "Enabled"

    filter {}

    expiration {
      days = var.query_results_retention_days
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}

# Block public access for query results bucket
resource "aws_s3_bucket_public_access_block" "query_results" {
  bucket = aws_s3_bucket.query_results.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
