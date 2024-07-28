# Business Performance and Customer Insights Analysis

## 1. Introduction
In today's competitive business environment, having a deep understanding of business performance and customer insights is crucial for making informed strategic decisions. This project aims to provide comprehensive insights into various aspects of business performance, including sales trends, profitability, customer behavior, and market dynamics.

### Project Objective
The primary objective of this project is to analyze business performance indexes and customer insights to help businesses identify key areas for improvement, optimize operations, and enhance overall profitability. The project focuses on answering critical business questions related to sales, profitability, customer behavior, and market trends.

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
The dataset used for this analysis was sourced from Kaggle, a platform known for its diverse and high-quality datasets. The data encompasses various aspects of sales and customer behavior, providing a robust foundation for detailed analysis.

### Tools and Technologies Used
- **Data Collection**: Jupyter Notebook, Kaggle API
- **Data Cleaning**: Pandas library in Python
- **Data Loading**: SQLAlchemy, ODBC connector driver, MySQL
- **Exploratory Data Analysis (EDA)**: MySQL Workbench
- **Data Visualization**: Power BI

By leveraging these tools and technologies, we have conducted a thorough analysis to uncover valuable insights that can drive business growth and enhance customer satisfaction.
## 2. Data Collection and Dataset

### Data Collection
To gather the necessary data for this analysis, we utilized the Kaggle API. The dataset was downloaded directly into a Jupyter Notebook, ensuring an efficient and automated data collection process.

#### Steps for Data Collection
1. **Authenticate with Kaggle API**: Authenticate using the Kaggle API key to gain access to the datasets.
2. **Download Dataset**: Use the Kaggle API to download the dataset.
3. **Unzip Dataset**: Unzip the downloaded dataset for further processing.

#### Code Snippet for Data Collection
```python
from kaggle.api.kaggle_api_extended import KaggleApi

# Authenticate Kaggle API
api = KaggleApi()
api.authenticate()

# Download dataset
dataset = 'your-dataset-name'  # Replace with your dataset name
api.dataset_download_files(dataset, path='path-to-save-dataset', unzip=True)
## Dataset Overview
The dataset consists of sales and customer data from a USA-based multipurpose store, covering the years 2022 and 2023. This data includes various features that provide detailed information on sales transactions, customer segments, product categories, and more.

### Schema of the Dataset
| Column Name      | Data Type |
|------------------|-----------|
| order_id         | int64     |
| order_date       | object    |
| ship_mode        | object    |
| segment          | object    |
| country          | object    |
| city             | object    |
| state            | object    |
| postal_code      | int64     |
| region           | object    |
| category         | object    |
| sub_category     | object    |
| product_id       | object    |
| cost_price       | int64     |
| list_price       | int64     |
| quantity         | int64     |
| discount_percent | int64     |
| discount         | float64   |
| sale_price       | float64   |
| profit           | float64   |
| total_sale       | float64   |
| total_profit     | float64   |

### Key Features
- **Order Details**: Information about each order, including order ID, date, and ship mode.
- **Customer Segmentation**: Data on customer segments, helping to identify and analyze different customer groups.
- **Geographical Data**: Includes details on country, city, state, and region.
- **Product Information**: Details on product categories and sub-categories.
- **Pricing and Discounts**: Information on cost price, list price, discounts, and sale price.
- **Sales and Profit**: Data on sales amount, profit, and other financial metrics.
