variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "raw_bucket_name" {
  description = "Name of the raw zone S3 bucket"
  type        = string
}

variable "curated_bucket_name" {
  description = "Name of the curated zone S3 bucket"
  type        = string
}

variable "crawler_role_arn" {
  description = "ARN of the IAM role for Glue Crawler"
  type        = string
}

variable "etl_job_role_arn" {
  description = "ARN of the IAM role for Glue ETL Job"
  type        = string
}

variable "database_name" {
  description = "Name of the Glue Data Catalog database"
  type        = string
  default     = "spotify_db"
}
