# Glue Resources for ETL Pipeline

# Glue Database
resource "aws_glue_catalog_database" "etl_database" {
  name        = var.database_name
  description = "Database for ${var.project_name} ETL pipeline"

  tags = {
    Name        = "${var.project_name}-${var.environment}-database"
    Environment = var.environment
  }
}

# Glue Crawler for Raw Zone (CSV)
resource "aws_glue_crawler" "raw_zone" {
  name          = "${var.project_name}-${var.environment}-raw-crawler"
  role          = var.crawler_role_arn
  database_name = aws_glue_catalog_database.etl_database.name
  description   = "Crawler for raw CSV data in S3"

  s3_target {
    path = "s3://${var.raw_bucket_name}/spotify_data/"
  }

  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "LOG"
  }

  configuration = jsonencode({
    Version = 1.0
    CrawlerOutput = {
      Partitions = {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
    Grouping = {
      TableGroupingPolicy = "CombineCompatibleSchemas"
    }
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-raw-crawler"
    Environment = var.environment
    Zone        = "raw"
  }
}

# Glue Crawler for Curated Zone (Parquet)
resource "aws_glue_crawler" "curated_zone" {
  name          = "${var.project_name}-${var.environment}-curated-crawler"
  role          = var.crawler_role_arn
  database_name = aws_glue_catalog_database.etl_database.name
  description   = "Crawler for curated Parquet data in S3"

  s3_target {
    path = "s3://${var.curated_bucket_name}/spotify_data/"
  }

  schema_change_policy {
    update_behavior = "UPDATE_IN_DATABASE"
    delete_behavior = "LOG"
  }

  configuration = jsonencode({
    Version = 1.0
    CrawlerOutput = {
      Partitions = {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
    Grouping = {
      TableGroupingPolicy = "CombineCompatibleSchemas"
    }
  })

  tags = {
    Name        = "${var.project_name}-${var.environment}-curated-crawler"
    Environment = var.environment
    Zone        = "curated"
  }
}

# Glue ETL Job
resource "aws_glue_job" "etl_job" {
  name     = "${var.project_name}-${var.environment}-etl-job"
  role_arn = var.etl_job_role_arn

  command {
    name            = "glueetl"
    script_location = "s3://${var.curated_bucket_name}/scripts/etl_job.py"
    python_version  = "3"
  }

  glue_version = "4.0"

  worker_type       = "G.1X"
  number_of_workers = 2

  default_arguments = {
    "--job-language"                     = "python"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--enable-metrics"                   = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-spark-ui"                  = "true"
    "--spark-event-logs-path"            = "s3://${var.curated_bucket_name}/spark-logs/"
    "--TempDir"                          = "s3://${var.curated_bucket_name}/temp/"
    "--source_database"                  = aws_glue_catalog_database.etl_database.name
    "--target_path"                      = "s3://${var.curated_bucket_name}/spotify_data/"
  }

  execution_property {
    max_concurrent_runs = 1
  }

  timeout     = 30
  max_retries = 1

  tags = {
    Name        = "${var.project_name}-${var.environment}-etl-job"
    Environment = var.environment
  }
}
