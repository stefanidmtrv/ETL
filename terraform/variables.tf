# Variables for AWS ETL Pipeline Infrastructure

variable "project_name" {
  description = "Name of the project, used for resource naming"
  type        = string
  default     = "etl-pipeline"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "eu-west-2"
}

variable "raw_retention_days" {
  description = "Number of days to retain raw data in S3"
  type        = number
  default     = 90
}

variable "query_results_retention_days" {
  description = "Number of days to retain Athena query results"
  type        = number
  default     = 7
}

variable "bytes_scanned_cutoff_per_query" {
  description = "Maximum bytes scanned per query in Athena (data usage control). Set to 0 to disable."
  type        = number
  default     = 1073741824 # 1 GB default limit
}

variable "glue_database_name" {
  description = "Name of the Glue Data Catalog database"
  type        = string
  default     = "spotify_db"
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
