variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "raw_retention_days" {
  description = "Number of days to retain raw data"
  type        = number
}

variable "query_results_retention_days" {
  description = "Number of days to retain query results"
  type        = number
}
