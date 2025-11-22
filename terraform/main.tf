# Main Terraform configuration for AWS ETL Pipeline

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# S3 Buckets
module "s3_buckets" {
  source = "./modules/s3"

  project_name                 = var.project_name
  environment                  = var.environment
  raw_retention_days           = var.raw_retention_days
  query_results_retention_days = var.query_results_retention_days
}

# IAM Roles and Policies
module "iam" {
  source = "./modules/iam"

  project_name             = var.project_name
  environment              = var.environment
  raw_bucket_arn           = module.s3_buckets.raw_bucket_arn
  curated_bucket_arn       = module.s3_buckets.curated_bucket_arn
  query_results_bucket_arn = module.s3_buckets.query_results_bucket_arn
}

# Glue Resources
module "glue" {
  source = "./modules/glue"

  project_name        = var.project_name
  environment         = var.environment
  database_name       = var.glue_database_name
  raw_bucket_name     = module.s3_buckets.raw_bucket_name
  curated_bucket_name = module.s3_buckets.curated_bucket_name
  crawler_role_arn    = module.iam.glue_crawler_role_arn
  etl_job_role_arn    = module.iam.glue_etl_job_role_arn
}

# Athena Workgroup
module "athena" {
  source = "./modules/athena"

  project_name                   = var.project_name
  environment                    = var.environment
  query_results_bucket_name      = module.s3_buckets.query_results_bucket_name
  bytes_scanned_cutoff_per_query = var.bytes_scanned_cutoff_per_query
}
