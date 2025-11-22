variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "query_results_bucket_name" {
  description = "Name of the S3 bucket for query results"
  type        = string
}

variable "bytes_scanned_cutoff_per_query" {
  description = "Maximum bytes scanned per query (data usage control). Set to 0 to disable."
  type        = number
  default     = 1073741824 # 1 GB default limit
}
