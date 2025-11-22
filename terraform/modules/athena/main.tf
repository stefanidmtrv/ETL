# Athena Workgroup for ETL Pipeline

resource "aws_athena_workgroup" "etl_workgroup" {
  name        = "${var.project_name}-${var.environment}-workgroup"
  description = "Workgroup for ${var.project_name} ETL pipeline queries"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${var.query_results_bucket_name}/results/"

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }

    engine_version {
      selected_engine_version = "AUTO"
    }

    # Data usage controls and query limits
    bytes_scanned_cutoff_per_query = var.bytes_scanned_cutoff_per_query
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-workgroup"
    Environment = var.environment
  }
}
