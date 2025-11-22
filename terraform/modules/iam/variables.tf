variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "raw_bucket_arn" {
  description = "ARN of the raw zone S3 bucket"
  type        = string
}

variable "curated_bucket_arn" {
  description = "ARN of the curated zone S3 bucket"
  type        = string
}

variable "query_results_bucket_arn" {
  description = "ARN of the query results S3 bucket"
  type        = string
}
