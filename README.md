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
   password = '**********'
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

## 5. Exploratory Data Analysis (EDA)

Exploratory Data Analysis (EDA) is a crucial step to understand the underlying patterns and relationships within the dataset. For this project, EDA was performed using MySQL Workbench by executing SQL queries to answer key business questions. Below are the key questions, the SQL queries used to address them, and snapshots of the query outputs.

### Key Questions and SQL Queries
- **Sales Analysis**
  1. What are the total sales over different months?
  ```sql
  SELECT DATE_FORMAT(order_date, "%Y %m") AS month, SUM(total_sale) AS total_sales
  FROM df_orders
  GROUP BY month
  ORDER BY month;
  ```
   
  2. Which regions have the highest and lowest sales?
  ```sql
  SELECT region, SUM(total_sale) AS total_sales
  FROM furniture.df_orders
  GROUP BY region
  ORDER BY total_sales DESC
  LIMIT 1;
  ```
  ```sql
  SELECT region, SUM(revenue) AS total_sales
  FROM furniture.df_orders
  GROUP BY region
  ORDER BY total_sales 
  LIMIT 1;
  ```
  3. How do sales vary by ship mode and segment?
  ```sql
  SELECT ship_mode, segment, SUM(revenue) AS sales
  FROM furniture.df_orders
  WHERE ship_mode IS NOT NULL AND segment IS NOT NULL
  GROUP BY ship_mode, segment
  ORDER BY ship_mode;
  ```
- **Profitability Analysis**
  4. Which regions are the most and least profitable?
  ```sql
  SELECT region, SUM(gross_profit) total_profit
  FROM furniture.df_orders
  GROUP BY region;
  ```
  5. What is the impact of discounts on profit margins?
  ```sql
  SELECT discount, AVG(profit / (sale_price * quantity)) AS avg_profit_margin
  FROM furniture.df_orders
  GROUP BY discount
  ORDER BY discount;
  ```
- **Customer Insights**
  6. Which customer segments generate the most revenue?
  ```sql
  SELECT segment, SUM(total_sale) AS total_revenue
  FROM furniture.df_orders
  GROUP BY segment;
  ```
  7. How does the average order size and frequency of orders vary across different segments?
  ```sql
  SELECT segment, AVG(quantity) AS avg_order_size, COUNT(order_id) AS order_count
  FROM your_table_name
  GROUP BY segment
  ORDER BY order_count DESC;
  ```
- **Market Trends**
  8. What are the trends in sales and profit over time?
  ```sql
  SELECT  DATE_FORMAT(order_date, "%Y %m") AS month, SUM(total_sale) AS sales, SUM(profit) AS profit
  FROM furniture.df_orders
  GROUP BY month
  ORDER BY month;
  ```
  9. Are there seasonal variations in sales and profitability?
  ```sql
  SELECT MONTH(order_date) AS month, SUM(total_sale) AS sales, SUM(total_profit) AS profit
  FROM furniture.df_orders
  GROUP BY month
  ORDER BY month;
  ```
- **Inventory and Supply Chain**
  10. Which Sub-category have the highest and lowest order quantities?
  ```sql
  SELECT sub_category, SUM(quantity) AS total_order_quantity 
  FROM furniture.df_orders
  GROUP BY sub_category
  ORDER BY total_order_quantity DESC;
  ```
- **Geographical Insights**
  11. Which cities and states have the highest sales?
  ```sql
  SELECT state, city, SUM(total_sale) AS total_sales
  FROM furniture.df_orders
  GROUP BY state, city;
  ```
- **Discount Effectiveness**
  12. How do different levels of discount affect sales volume?
  ````sql
  SELECT discount_percent, SUM(total_sale) AS total_sales
  FROM furniture.df_orders
  GROUP BY discount_percent
  ```
### Results and Insights
By performing these SQL queries, we gained valuable insights into the store's operations, sales patterns, profitability, customer behavior, and market trends. These insights can be leveraged to make data-driven decisions, optimize strategies, and improve overall business performance.
## 6. Visualizations in Power BI

The following visualizations provide a comprehensive analysis of sales data and business performance. Each chart is designed to highlight different aspects of the dataset, offering insights into revenue trends, sales performance, and more.

### Visualizations

- **Revenue and Profit Trends (Line Graph with Multiple Y-Axis):**
  This line graph displays how revenue and profit change over time. Separate y-axes are used for each metric to handle different scales effectively, allowing for a clear view of trends in both revenue and profit.
  
- **Top Selling Categories and Subcategories (Funnel Chart):**
  The funnel chart illustrates the hierarchical flow of sales through various categories and subcategories. It shows how sales diminish as you move from top-level categories to more detailed subcategories.
  
- **Sales Performance by Region (Map Chart):**
  A map chart visualizes sales data geographically. It helps in understanding variations in sales performance across different regions, providing a spatial representation of sales distribution.
  
- **Revenue and Profit by Region (Clustered Column Chart):**
  This clustered column chart compares revenue and profit across regions side-by-side. It facilitates easy comparison of these metrics and highlights performance differences between regions.
  
- **Sales by Ship Mode and Segment (Clustered Column Chart):**
  The clustered column chart compares sales performance across different ship modes and customer segments. It helps in identifying trends and variations in sales related to shipping methods and customer segments.
  
- **Discount by Sale Price (Scatter Plot):**
  This scatter plot explores the relationship between discount percentages and sale prices. It is useful for identifying patterns or anomalies in how discounts impact sale prices.
  
- **Discount by Profit Margin (Scatter Plot):**
  A scatter plot showing the relationship between discounts and profit margins. This visualization helps in understanding how varying discount levels affect profitability.
  
- **Average Order Size and Number of Orders (Combo of Column and Line Chart):**
  The combo chart displays trends in both average order size and the number of orders over time. Columns represent average order size, while a line tracks the number of orders, providing a combined view of these two metrics.

These visualizations offer valuable insights into different dimensions of business performance, aiding in data-driven decision-making and strategic planning.

## 7.  Sales Data Insights

### Regional Sales Insights

- **Top Performing Region:** The West region consistently shows the highest sales, peaking at $3,467,409.60. This indicates strong market performance and possibly effective regional strategies.

- **Lowest Performing Region:** The South region has the lowest sales, with a total of $1,966,053.60. This suggests a need for a closer examination of market conditions or sales strategies in this area.

### Sales by Ship Mode and Segment

- **First Class:** The highest sales are achieved through the Standard Class, contributing $3,451,052.10, followed by Second Class at $1,201,220.50. This suggests that customers are willing to pay more for faster delivery options.

- **Same Day:** Sales from Same Day delivery are lower compared to Standard Class but still significant, with Consumer segments contributing $269,503.30. This could indicate a growing preference for expedited services.

### Profitability by Region

- **Most Profitable Region:** The West region leads in profitability with $305,289.60. This could indicate efficient cost management and high-margin products in this region.

- **Least Profitable Region:** The South region shows the lowest profit at $202,743.60. This could highlight potential issues with cost control or lower-margin sales in this area.

### Impact of Discounts on Profit Margins

- **Discount Trends:** Discounts have a varied impact on profit margins. For example, a discount of 2.40% shows an increased profit margin of 0.0334, while a discount of 5.00% has a slightly decreased margin of 0.0284. This indicates that moderate discounts might boost profitability, but high discounts can reduce profit margins.

## 8. Actionable Recommendations

### Regional Strategies

- **Enhance South Region Sales:** Focus on improving sales strategies in the South region to boost performance. Consider evaluating market conditions, customer preferences, and competitive strategies to identify and address the underlying issues.

### Optimize Shipping Options

- **Promote Standard and Second Class Shipping:** Continue to emphasize Standard and Second Class shipping options, as they significantly contribute to overall sales. Explore opportunities to enhance Same Day delivery options to capture a larger share of that market segment.

### Boost Profit Margins

- **Optimize Discount Strategies:** Implement pricing strategies that balance discounts with profit margins. Analyze the effectiveness of various discount levels to identify the optimal range that maintains or increases profitability without adversely affecting margins.

### Regional Profitability

- **Investigate South Region Cost Structures:** Conduct a detailed analysis of cost structures in the South region to identify potential areas for cost reduction or margin improvement. Focus on optimizing operational efficiency and improving cost control to enhance profitability in this region.


