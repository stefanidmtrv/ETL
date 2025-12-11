## Architecture

```
(Local CSV/spotify_data)
         |
         ▼
Amazon S3 (raw/spotify_data/)
         |
         ▼
Glue Crawler → Glue Data Catalog (spotify_db)
         |
         ▼
Glue ETL Job → Parquet Output
         |
         ▼
Amazon S3 (curated/spotify_data/)
         |
         ▼
Amazon Athena &rarr; Power BI (ODBC)
```