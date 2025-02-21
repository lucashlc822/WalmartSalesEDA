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








