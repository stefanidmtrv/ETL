CSV Upload
    ↓
Raw S3 Bucket (etl-pipeline-dev-raw-zone)
    ↓
Raw Crawler → Glue Catalog
    ↓
ETL Job reads from catalog
    ↓
ETL Job writes Parquet
    ↓
Curated S3 Bucket (etl-pipeline-dev-curated-zone)
    ↓
Athena queries directly from S3
    ↓
Power BI