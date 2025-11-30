"""
Run the Glue Crawler to discover data schema and populate the Data Catalog.
"""

import boto3
import time

CRAWLER_NAME = "etl-pipeline-dev-raw-crawler"
DATABASE_NAME = "spotify_db"

def run_crawler():
    glue = boto3.client('glue')
    
    glue.start_crawler(Name=CRAWLER_NAME)
    print("Scanning S3 and discovering schema...")
    
    max_wait = 300
    elapsed = 0
    
    while elapsed < max_wait:
        response = glue.get_crawler(Name=CRAWLER_NAME)
        state = response['Crawler']['State']
        
        if state == 'READY':
            last_crawl = response['Crawler']['LastCrawl']
            
            if last_crawl['Status'] == 'SUCCEEDED':
                print(f"Complete")
                
                tables = glue.get_tables(DatabaseName=DATABASE_NAME)
                for table in tables['TableList']:
                    print(f"  {table['Name']} ({len(table['StorageDescriptor']['Columns'])} columns)")
                return
            else:
                print(f"Failed: {last_crawl.get('ErrorMessage', 'Unknown error')}")
                return
        
        print(".", end="", flush=True)
        time.sleep(5)
        elapsed += 5
    
    print(f"Timeout after {max_wait}s")

if __name__ == '__main__':
    run_crawler()
