

use furniture;
select * from df_orders;
-- Sales Analysis 
-- What are the total sales over different months? -> line graph
SELECT date_format(order_date, "%Y %m") as month, sum(total_sale) as total_sales
from df_orders
group by month
order by month;

-- Which regions have the highest and lowest sales?
SELECT region, sum(total_sale) as total_sales
FROM furniture.df_orders
GROUP BY region
ORDER BY total_sales DESC;

SELECT region, sum(revenue) as total_sales
FROM furniture.df_orders
GROUP BY region
ORDER BY total_sales 
LIMIT 1;

-- How do sales vary by ship mode and segment?
SELECT ship_mode, segment, SUM(revenue) as sales
FROM furniture.df_orders
WHERE ship_mode IS NOT NULL AND segment IS NOT NULL
GROUP BY ship_mode, segment
ORDER BY ship_mode;

-- Profitability Analysis
-- Which regions are the most and least profitable?
SELECT region, SUM(gross_profit) total_profit
FROM furniture.df_orders
GROUP BY region;

-- What is the impact of discounts on profit margins?
-- profit margin column need to be created in power bi
SELECT discount, AVG(profit / (sale_price * quantity)) AS avg_profit_margin
FROM furniture.df_orders
GROUP BY discount
ORDER BY discount;


-- Customer Insights
-- Which customer segments generate the most revenue?
select segment, sum(total_sale) as total_revenue
from furniture.df_orders
group by segment;

-- How does the average order size and frequency of orders vary across different segments?
SELECT segment, AVG(quantity) AS avg_order_size, COUNT(order_id) AS order_count
FROM your_table_name
GROUP BY segment
ORDER BY order_count DESC;




-- Market Trends
-- What are the trends in sales and profit over time? -> line graph
select  date_format(order_date, "%Y %m") as month, sum(total_sale) as sales, sum(profit) as profit
from furniture.df_orders
group by month
order by month;

-- Are there seasonal variations in sales and profitability?
select month(order_date) as month, sum(total_sale) as sales, sum(total_profit) as profit
from furniture.df_orders
group by month
order by month;

-- Which Sub-category have the highest and lowest order quantities?
select sub_category, sum(quantity) as total_order_quantity 
from furniture.df_orders
group by sub_category
order by total_order_quantity desc;


-- Write a query to sum the sales amount for each city and state and order the results.
select state, city, sum(total_sale) as total_sales
from furniture.df_orders
group by state, city;

-- How do different levels of discount affect sales volume?
	select discount_percent, sum(total_sale) as total_sales
	from furniture.df_orders
	group by discount_percent