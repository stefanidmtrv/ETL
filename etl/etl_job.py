"""
AWS Glue ETL Job: CSV to Parquet conversion
"""

import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame
from pyspark.sql import functions as F

args = getResolvedOptions(sys.argv, ['JOB_NAME', 'source_database', 'target_path'])

# Initialize Glue/Spark
sc = SparkContext()
glueContext = GlueContext(sc)
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

try:
    # Read from Glue Catalog    
    datasource = glueContext.create_dynamic_frame.from_catalog(
        database=args['source_database'],
        table_name="spotify_data",
        transformation_ctx="read_source"
    )
        
    # Convert to DataFrame and check schema
    df = datasource.toDF()
    df.printSchema()
    
    df.show(5)
    
    # Simple cleaning - just add year and timestamp
    df_clean = df.withColumn("year", F.lit(2024))
    df_clean = df_clean.withColumn("processed_at", F.current_timestamp())
    
    # Write as Parquet    
    output_frame = DynamicFrame.fromDF(df_clean, glueContext, "output")
    
    # Try writing without partitioning first
    # TO-DO: fix this
    simple_path = args['target_path'] + "simple/"
    
    glueContext.write_dynamic_frame.from_options(
        frame=output_frame,
        connection_type="s3",
        connection_options={
            "path": simple_path
        },
        format="parquet",
        format_options={"compression": "snappy"},
        transformation_ctx="write_parquet"
    )
    
    print("ETL completed successfully!")
    
except Exception as e:
    print(f"ETL failed: {str(e)}")
    import traceback
    traceback.print_exc()
    raise

finally:
    job.commit()