import base64
import json
import os
from datetime import datetime

import boto3
import pandas as pd
import requests
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator


# Define default_args with your desired DAG parameters
default_args = {
    'owner': 'utkarsh',
    'start_date': datetime(2023, 9, 12),
    'retries': 1,
}

# Define the DAG
dag = DAG(
    'opensource_API_details',
    default_args=default_args,
    description='DAG to modify a CSV file and upload it to S3',  # Set your desired schedule_interval here
    catchup=False,
)

# Define a Python function to upload the modified CSV to S3
# aws_access_key_id = 'AKIA232YWEHGFVWBMAOD'
# aws_secret_access_key = 'ZvUbWEOS/YZJeHSXYEzEGcNPctZVXkjnYX0EKwcI'

dags_directory = os.path.dirname(__file__)
input_json_path = os.path.join(dags_directory + '/tmp/' + 'aws.json')
# Read AWS credentials from the JSON file
with open(input_json_path, 'r') as file:
    aws_key = json.load(file)
    aws_keys = aws_key.get("aws")

# Extract the access keys
aws_access_key_id_encoded = aws_keys.get("AccessKey")
aws_secret_access_key_encoded = aws_keys.get("SecretAccessKey")
aws_access_key_id = base64.b64decode(aws_access_key_id_encoded).decode('utf-8')
aws_secret_access_key = base64.b64decode(aws_secret_access_key_encoded).decode('utf-8')

if aws_access_key_id and aws_secret_access_key:
    print("AWS Access Key ID:", aws_access_key_id)
    print("AWS Secret Access Key:", aws_secret_access_key)
else:
    print("AWS keys not found in the JSON file.")

session = boto3.session.Session(
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key)

client = session.client(
    service_name='secretsmanager',
    region_name='ap-south-1',
)
secret = client.get_secret_value(SecretId="access_secret_keys")
print(secret['SecretString'])
secret_keys = json.loads(secret['SecretString'])


def upload_to_s3():
    print(secret_keys)
    base_url = secret_keys['public_api']
    topic = '&q=sports'
    api_key = secret_keys['apiKey']
    public_api = base_url+topic+'&from=2023-10-02&apiKey='+api_key
    print(public_api)
    output_csv_path = os.path.join(dags_directory + '/tmp/' + 'output.csv')
    try:
        # Make an HTTP request to the public API
        response = requests.get(public_api)
        response.raise_for_status()
        api_data = response.json()
        print("Total Rows in data : " + str(api_data["totalResults"]))
        # Check if the API response contains the data you need
        if 'articles' in api_data:
            api_data = api_data['articles']
            # Convert the data to a pandas DataFrame
            df = pd.DataFrame(api_data)
            # Save the DataFrame to a CSV file
            # print(df)
            df.to_csv(output_csv_path, index=False)
            print(f"Data saved to {output_csv_path}")

    except requests.exceptions.RequestException as e:
        print(f"Error making the API request: {str(e)}")

    s3_bucket_name = secret_keys['bucket']
    s3_client = session.client(service_name='s3')
    # Create a new filename with the UUID and .csv extension
    new_filename = f'api/output.csv'
    s3_client.upload_file(output_csv_path, s3_bucket_name, new_filename)


# Define the function to fetch data from the source S3 bucket
def moved_to_processed_folder():
    # Specify the S3 object key and destination key (you can modify this as needed)
    source_object_key = 'api/output.csv'
    destination_object_key = 'processed_folder/outputProcessed.csv'

    s3_client = session.client(service_name='s3')
    source_bucket = secret_keys['bucket']
    target_bucket = secret_keys['target_bucket']
    try:
        # s3.Bucket(destination_bucket_name).upload_file(Filename='/Sample.csv' , Key='Sample.csv')
        s3_client.copy_object(
            CopySource={'Bucket': source_bucket, 'Key': source_object_key},
            Bucket=source_bucket,
            Key=destination_object_key
        )

        print(
            f"Data copied from {source_bucket}/{source_object_key} to {target_bucket}/{destination_object_key}")
    except Exception as e:
        print(f"Error: {str(e)}")

# Define Python operators


def update_token_in_db():
    print("Updating token in db")
    return


snowflake_connection = secret_keys['snowflake_connection_name']

fetch_token = PythonOperator(
    task_id='fetch_token_authentication',
    python_callable=update_token_in_db,  # Pass the output of the previous task as an argument
    dag=dag,
)

API_data = PythonOperator(
    task_id='api_data',
    python_callable=update_token_in_db,  # Pass the output of the previous task as an argument
    dag=dag,
)
upload_to_s3_operator = PythonOperator(
    task_id='upload_to_s3',
    python_callable=upload_to_s3,  # Pass the output of the previous task as an argument
    dag=dag,
)


insert_into_snowflake_task = SnowflakeOperator(
    task_id='insert_into_snowflake',
    sql="COPY INTO news_table from @AWS_STG2 FILE_FORMAT = (TYPE = CSV FIELD_DELIMITER = ',' SKIP_HEADER = 1 "
        "error_on_column_count_mismatch=false);",
    snowflake_conn_id=snowflake_connection,
    autocommit=True,  # Set to True to execute the SQL immediately
    dag=dag,
)

transform_data = PythonOperator(
    task_id='DBT_transformation_of_data',
    python_callable=upload_to_s3,  # Pass the output of the previous task as an argument
    dag=dag,
)

moved_to_processed_folder = PythonOperator(
    task_id='moved_to_processed_folder',
    python_callable=moved_to_processed_folder,  # Pass the output of the previous task as an argument
    dag=dag,
)

update_token = PythonOperator(
    task_id='updating_token',
    python_callable=update_token_in_db,  # Pass the output of the previous task as an argument
    dag=dag,
)

# Set task dependencies
fetch_token >> API_data >> upload_to_s3_operator >> insert_into_snowflake_task >> transform_data >> moved_to_processed_folder
insert_into_snowflake_task
