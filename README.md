## Project Summary
This project showcases the implementation of a complete **Data Engineering pipeline** using modern technologies like **Python**, **Apache Airflow**, **Snowflake**, and **AWS Services**. The pipeline is designed to process batched news data at regular intervals, ensuring efficient and secure data processing from extraction to storage.

The main tasks involved in the project include:
- Extracting batched data from news api 
- Storing and transferring the data using AWS S3.
- Creating and loading a Snowflake-managed table with the processed data.
- Monitoring and scheduling the workflow using Apache Airflow.

## Project Architecture Diagram
Below is a high-level architecture of the data pipeline:

![Project Architecture Diagram](https://github.com/shirsendu849/news-data-pipeline/blob/main/airflow_project_architecture_diagram.PNG)

**Architecture Summary:**
1. **Data Source**: Batch news data is fetched using a Python script from [News API](https://newsapi.org/).
2. **Data Transfer**: The batched data is moved from **EC2** to **S3** via Airflow's BashOperator.
3. **Snowflake Integration**: Data is loaded into Snowflake using SnowflakeOperators.
4. **Data Processing**: Snowflake processes the data for analytics and reporting.

## Project Overview
### 1. Airflow DAG Setup
- The **Airflow DAG** comprises four tasks: a **PythonOperator**, a **BashOperator**, and two **SnowflakeOperators**. The DAG is hosted on an AWS EC2 instance.

### 2. Data Extraction using Python
- A **Python script** is responsible for extracting batched news data and storing it as a **Parquet file** on the EC2 instance.

### 3. File Transfer to AWS S3
- The **BashOperator** moves the Parquet file from the EC2 instance to an **AWS S3 bucket**. An IAM role is attached to the EC2 instance to facilitate secure communication.

### 4. Snowflake Table Creation
- The first **SnowflakeOperator** creates a Snowflake-managed table by inferring schema details from the Parquet file, ensuring seamless data integration.
  
### 5. Data Loading to Snowflake
- The second **SnowflakeOperator** copies the data from S3 to Snowflake, making it ready for ad-hoc queries and analysis.

---

## Technologies Used
- **Python**
- **Apache Airflow**
- **AWS EC2 and S3**
- **Snowflake**

---

## How to Run This Project
1. Set up an AWS EC2 instance and set up Airflow, Python, other dependencies.
2. Clone the [Github Repo](https://github.com/shirsendu849/news-data-pipeline.git) and copy, paste snowflake_automation_dag.py, news_fetcher_etl.py files into EC2 machine using WinSCP.
3. Attach an IAM role to your EC2 instance to allow communication with S3.
4. Create a S3 bucket in AWS.
5. Logged in into your Snowflake Accout, first create storage integration instance by providing S3 bucket path, arn value and establish trust relationship between Snowflake & AWS.
   Refer [Snowflake Doc](https://docs.snowflake.com/en/sql-reference/sql/create-storage-integration).
7. Configure snowflake connection from Airflow UI to work with Snowflake.
8. Initiate manual run to the DAG named snowflake_automation_dag from airflow UI and Query the destination table in Snowflake for further analysis.
