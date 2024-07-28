# Business Performance and Customer Insights Analysis

## 1. Introduction
In today's competitive business environment, understanding business performance and customer insights is crucial for making informed strategic decisions. This project aims to provide comprehensive insights into various aspects of business performance, including sales trends, profitability, customer behavior, and market dynamics, using data from a USA-based furniture store for the years 2022 and 2023.
### Project Objective
The primary objective of this project is to analyze business performance indexes and customer insights to help the business identify key areas for improvement, optimize operations, and enhance overall profitability. The project focuses on answering critical business questions related to sales, profitability, customer behavior, and market trends.
### Key Questions Addressed

#### Sales Analysis
- What are the total sales over different months?
- Which regions have the highest and lowest sales?
- How do sales vary by ship mode and segment?

#### Profitability Analysis
- Which regions are the most and least profitable?
- What is the impact of discounts on profit margins?

#### Customer Insights
- Which customer segments generate the most revenue?
- How does the average order size and frequency of orders vary across different segments?

#### Market Trends
- What are the trends in sales and profit over time?
- Are there seasonal variations in sales and profitability?
- Which sub-categories have the highest and lowest order quantities?
- How do different levels of discount affect sales volume?
### Dataset Source
The dataset used for this analysis is sourced from Kaggle, a platform known for its diverse and high-quality datasets. The data encompasses various aspects of sales and customer behavior from a USA-based furniture store, providing a robust foundation for detailed analysis.

### Tools and Technologies Used
- **Data Collection**: Jupyter Notebook, Kaggle API
- **Data Cleaning**: Pandas library in Python, Jupyter Notebook
- **Data Loading**: SQLAlchemy, ODBC connector driver, MySQL Workbench
- **Exploratory Data Analysis (EDA)**: MySQL 
- **Data Visualization**: Power BI

By leveraging these tools and technologies, we have conducted a thorough analysis to uncover valuable insights that can drive business growth and enhance customer satisfaction.
## 2. Data Collection and Dataset

### Data Collection
To gather the necessary data for this analysis, we utilized the Kaggle API. The dataset was downloaded directly into a Jupyter Notebook, ensuring an efficient and automated data collection process.

#### Steps for Data Collection
1. **Authenticate with Kaggle API**: Authenticate using the Kaggle API key to gain access to the datasets.
2. **Download Dataset**: Use the Kaggle API to download the dataset.
   ```python
   #importing required kaggle data from using kaggle API and auth token.
   import kaggle

   !kaggle datasets download ankitbansal06/retail-orders -f orders.csv
   ```
3. **Unzip Dataset**: Unzip the downloaded dataset for further processing.
   ```python
   #extract file from zip file
   import zipfile
   zip_ref = zipfile.ZipFile('orders.csv.zip') 
   zip_ref.extractall() # extract file to dir
   zip_ref.close() # close file
   ```
### Dataset Overview

The dataset consists of sales and customer data from a USA-based furniture store, covering the years 2022 and 2023. This data includes various features that provide detailed information on sales transactions, customer segments, product categories, and more.
#### Schema of the Dataset

| Column Name       | Data Type |
|-------------------|-----------|
| Order Id          | integer   |
| Order Date        | string    |
| Ship Mode         | string    |
| Segment           | string    |
| Cuntry            | string    |
| City              | string    |
| State             | string    |
| Postal Code       | integer   |
| Region            | string    |
| Category          | string    |
| Sub Category      | string    |
| Product Id        | string    |
| Cost Price        | integer   |
| List Price        | integer   |
| Quantity          | integer   |
| Discount Percent  | integer   |
#### Key Features

- **Order Details**: Information about each order, including order ID, date, and ship mode.
- **Customer Segmentation**: Data on customer segments, helping to identify and analyze different customer groups.
- **Geographical Data**: Includes details on country, city, state, and region.
- **Product Information**: Details on product categories and sub-categories.
- **Pricing and Discounts**: Information on cost price, list price, discounts, and sale price.
- **Sales and Profit**: Data on sales amount, profit, and other financial metrics.

This dataset provides a comprehensive view of the store's operations, enabling detailed analysis and insights into various aspects of business performance.

## 3. Data Cleaning

Data cleaning is a crucial step in the data analysis process. It involves identifying and correcting errors, handling missing values, and transforming data into a suitable format for analysis. In this project, the Pandas library in Python was used for data cleaning.

### Steps in Data Cleaning

1. **Load the Dataset**: 
   ```python
   #importing pandas library
   import pandas as pd
   #importing orders.csv, converting 'Not Available' & 'unknown' to 'nan' by default
   df = pd.read_csv('orders.csv',na_values = ['Not Available', 'unknown'])
   ```
2. **Checking for Unique Values**:
   ```python
   #Which unique values 'Ship Mode' column has
   df['Ship Mode'].unique()
   ```
3. **Cleaning Column Names**:
   ```python
   #Changing all column names to lowercase
   df.columns = df.columns.str.lower()
   #df.columns
   #Replacing spaces in column names to underscore
   df.columns = df.columns.str.replace(" ", "_")
   ```
4. **Deriving New Columns Required for Analysis**
   ```python
   #derive new columns discount, sale price, profit
   df['discount'] = df['list_price']*(df['discount_percent']/100)
   df['sale_price'] = df['list_price']-df['discount']
   df['profit'] = df['sale_price'] - df['cost_price']
   df['total_sale'] = df['sale_price']*df['quantity'] 
   df['total_profit'] = df['profit']*df['quantity']
   ```
5. **Displaying Cleaned DataFrame**
   ```python
   df.dtypes
   df.head(5)
   ```
## 4. Data Uploading 

Once the data is cleaned, the next step is to upload it into a MySQL database for further analysis using SQL. I have used the SQLAlchemy library to facilitate this process.

### Steps for Data Uploading

1. **Install SQLAlchemy and MySQL Connector**: Ensure you have the necessary libraries installed.
   ```python
   !pip install sqlalchemy pymysql mysqlclient
   ```
4. **Define the Database Connection String**: Create a connection string to connect to your MySQL database.
   ```python
   import sqlalchemy as sal
   import pandas as pd
   username = 'root'
   password = 'Abhi%401999'
   host = 'localhost'
   database = 'furniture'
   connection_string = f'mysql+pymysql://{username}:{password}@{host}/{database}'
   engine = sal.create_engine(connection_string)
   conn = engine.connect()
   ```
6. **Create a MySQL Database**: Set up a MySQL database to store your data.
   ```python
   from sqlalchemy import create_engine, MetaData, Table, Column, Integer, String, DECIMAL, Date
   metadata = MetaData()
   furniture_table = Table(
       'df_orders', metadata,
       Column('order_id', Integer, primary_key=True),
       Column('order_date', Date),
       Column('ship_mode', String(20)),
       Column('segment', String(20)),
       Column('country', String(20)),
       Column('city', String(20)),
       Column('state', String(20)),
       Column('postal_code', String(20)),
       Column('region', String(20)),
       Column('category', String(20)),
       Column('sub_category', String(20)),
       Column('product_id', String(50)),
       Column('cost_price', Integer),
       Column('list_price', Integer),
       Column('quantity', Integer),
       Column('discount_percent', Integer),
       Column('discount', DECIMAL(7,2)),
       Column('sale_price', DECIMAL(7,2)),
       Column('profit', DECIMAL(7,2)),
       Column('total_sale', DECIMAL(10,2)),
       Column('total_profit', DECIMAL(10,2))
   )
   metadata.create_all(engine)

   print("Table  created successfully.")
   ```
8. **Upload DataFrame to MySQL**: Use SQLAlchemy to upload the cleaned DataFrame to the MySQL database.
   ```python
   df.to_sql('df_orders', con=conn , index=False, if_exists = 'append')
   ```


