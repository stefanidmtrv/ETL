"""
Simple script to upload Spotify CSV data to S3 with date partitioning.
"""

import boto3
from datetime import datetime
from pathlib import Path

DATA_FILE = "../data/spotify_data_raw.csv"
BUCKET_NAME = "etl-pipeline-dev-raw-zone"
PREFIX = "spotify_data"

def upload_data():
    
    # Get the data file
    data_file = Path(__file__).parent / DATA_FILE
    
    if not data_file.exists():
        print(f"Error: File not found: {data_file}")
        return
    
    # Generate partition path: year=YYYY/month=MM/day=DD
    today = datetime.now()
    partition = f"year={today.year}/month={today.strftime('%m')}/day={today.strftime('%d')}"
    
    # Build S3 key
    filename = data_file.name
    s3_key = f"{PREFIX}/{partition}/{filename}"
    
    # Upload to S3
    print(f"Uploading {filename} to S3...")
    print(f"Bucket: {BUCKET_NAME}")
    print(f"Key: {s3_key}")
    
    try:
        s3 = boto3.client('s3')
        s3.upload_file(str(data_file), BUCKET_NAME, s3_key)
        print(f"\n Upload successful!")
    except Exception as e:
        print(f"\n Upload failed: {e}")

if __name__ == '__main__':
    upload_data()
