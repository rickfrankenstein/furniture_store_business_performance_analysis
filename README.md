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

