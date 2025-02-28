# WalmartSalesEDA
## Introduction
This project explores sales data retrieved by Walmart and pinpoints aspects of good performance and opportunities for business improvement. Sales trends are analyzed based on types of products, locations, and customer types. The dataset was retrieved from Kaggle via the [Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." ([source](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting))

The objective of this project is to gain a deep understanding of Walmart's sales data by identifying patterns, trends, outliers, and relationships between different variables. This **Exploratory Data Analysis** will provide a quantitative summary of the data and helps to ensure the results produced are valid and applicable to any desired business outcomes and goals.

## About the Data
As mentioned above, the Walmart sales data was retrieved from a dataset from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). The dataset contains sales transactions from three different Walmart branches located in Mandalay, Yangon, and Naypyitaw. There are 17 columns and around 1000 rows in total. Refer to ***Table 1*** below for further details of the data in each column.

### *Table 1* - Column Data Types

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product solf        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                 | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(10, 2) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment_method                 | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Rating                                  | FLOAT(2, 1)    |

## Analysis Categories
***1 - Product Analysis***

Dive into the different product lines, identifying top performers and weaker profiles.

***2 - Sales Analysis***

Discover sales trends and relationships to measure the effectiveness of every applied sales strategy, as well as brainstorm modifications for improving sales.

***3 - Customer Analysis***

Identify distinct customer segments, analyze purchasing trends, and evaluate the profitability of each segment.

## Procedure
***Data Wrangling*** - This is performed in the preliminary stages of the analysis, where the data is inspected to ensure any **NULL** or missing values are detected, then data replacement methods are used to replace them. Extreme values and outliers are also removed/adjusted to prevent the analysis from being skewed.
1. Database creation
2. Table creation and ETL of data from source files.
3. Filter and remove **NULL** values (column settings set for **NOT NULL**).

***Feature Engineering*** - Generating new calculation columns from existing source data. The following columns were created:
1. Added a new varchar column `time_of_day` to categorize the sales based on Morning, Afternoon, and Evening periods.
2. Added a new varchar column `day_name` to categorize the day of the week for each sale made (Monday, Tuesday, etc.).
3. Added a new varchar column `month_name` to categorize the month in which each sale was made, displayed in long format (January, February, March, etc.)

***Data Analysis*** - Finding relationships between variables in the data. Finding key performance indicators based on different categories. Identifying bright spots concerning sales and profitability.
1. Refer to the [Business Questions](##business-questions) section to view the focus points for exploration of the data.
2. Please go to the [SQL Queries](project_queries.sql) to view the results of the EDA.

***Conclusion*** - Overview of the results and providing strategic recommendations.

## Business Questions
### Introductory:
1. How many unique cities does the data have?
2. In which city is each branch?
### Product Analysis:
1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
7. What is the city with the largest revenue?
8. What product line had the largest VAT?
9. Fetch each product line and add a column to those product lines showing "Good", and "Bad". A product is considered "Good" if its total sales are greater than the average sales.
10. Which branch sold more products than the average product sold?
11. What is the most common product line by gender?
12. What is the average rating of each product line?
### Sales Analysis:
1. What is the total number of sales made at each time of the day per weekday?
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percentage/ VAT (Value Added Tax)?
4. Which customer type pays the most in VAT?
### Customer Analysis:
1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give the most ratings?
8. Which time of the day do customers give the most ratings per branch?
9. Which day of the week has the best average ratings?
10. Which day of the week has the best average ratings per branch?

## Calculations
The calculations below were performed throughout the analysis:
- Cost of Goods Sold, $COGS = unitPrice*quantity$
- Value Added Tax, $VAT = 0.05*COGS$
- Gross Sales $= VAT + COGS$
- Gross Profit $= Gross Sales - COGS$
- Gross Margin% $= GrossProfit / TotalRevenue * 100$













