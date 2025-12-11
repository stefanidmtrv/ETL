"""
Upload ETL job script to S3 for Glue to use
"""

import boto3
from pathlib import Path

# Configuration
SCRIPT_FILE = "etl_job.py"
BUCKET_NAME = "etl-pipeline-dev-curated-zone"  # Your curated bucket
S3_KEY = "scripts/etl_job.py"

def upload_etl_script():
    script_path = Path(__file__).parent / SCRIPT_FILE
    
    if not script_path.exists():
        print(f"Error: Script file not found: {script_path}")
        return
    
    print(f"Uploading {SCRIPT_FILE} to S3...")
    print(f"Bucket: {BUCKET_NAME}")
    print(f"Key: {S3_KEY}")
    
    try:
        s3 = boto3.client('s3')
        s3.upload_file(str(script_path), BUCKET_NAME, S3_KEY)
        print("Upload successful!")
        print(f"Script available at: s3://{BUCKET_NAME}/{S3_KEY}")
    except Exception as e:
        print(f"Upload failed: {e}")

if __name__ == '__main__':
    upload_etl_script()