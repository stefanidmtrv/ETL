# Data Directory

This directory contains CSV data files for the ETL pipeline.

## Getting the Data

### Option 1: Use Your Own Data
Place your CSV file here:
```
data/spotify_data_raw.csv
```

### Option 2: Download from Kaggle
Dataset: [Spotify Global Music Dataset (2009-2025)](https://www.kaggle.com/datasets/wardabilal/spotify-global-music-dataset-20092025)

1. Download the CSV from Kaggle
2. Place it in this directory
3. Rename to `spotify_data_raw.csv` (or update the script)

## Note
CSV files are not committed to git due to their size. The `.gitignore` excludes `*.csv` files.
