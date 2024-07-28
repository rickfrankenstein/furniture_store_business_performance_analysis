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
