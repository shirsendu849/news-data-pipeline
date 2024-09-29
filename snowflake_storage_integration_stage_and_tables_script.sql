// creating new database
CREATE OR REPLACE DATABASE news_db;

// selecting database
USE news_db;

// creating new schema
CREATE OR REPLACE SCHEMA news_db.news_info; 

// selecting schema
USE news_db.news_info; 

// creating storage integration instance
CREATE OR REPLACE STORAGE INTEGRATION s3_storage_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::339712789026:role/snowflake-s3-bucket-storage-integration-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://news-data-data-lake/');

// describe storage integration
DESC STORAGE INTEGRATION s3_storage_integration;

// creating new file format
CREATE OR REPLACE FILE FORMAT news_db.news_info.parquet_file_format
    TYPE='PARQUET'
    COMPRESSION = 'AUTO';

// creating new stage object
CREATE OR REPLACE STAGE news_db.news_info.external_stage_s3
    URL = 's3://news-data-data-lake/'
    STORAGE_INTEGRATION = s3_storage_integration
    FILE_FORMAT = news_db.news_info.parquet_file_format;

// list all contents in s3
LIST @news_db.news_info.external_stage_s3;

// checking the table is existed or not
SELECT table_name FROM information_schema.columns WHERE table_name = 'news_data';

// query the table
SELECT * FROM news_db.news_info.news_data LIMIT 100;







