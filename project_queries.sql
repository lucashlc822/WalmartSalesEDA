create database if not exists salesDataWalmart;

create table if not exists sales(
	invoice_id varchar(30) not null primary key,
    branch varchar(5) not null,
    city varchar(30) not null,
    customer_type varchar(30) not null,
    gender varchar(10) not null,
    product_line varchar(100) not null,
    unit_price decimal(10,2) not null,
    quantity int not null,
    VAT float(6, 4) not null,
    total decimal(12, 4) not null,
    date datetime not null,
    time time not null,
    payment_method varchar(15) not null,
    cogs decimal(10, 2) not null,
    gross_margin_pct float(11, 9),
    gross_income decimal(12, 4) not null,
    rating float(2, 1)
);

-- ---------------------------------------------------
-- ---------------------------------------------------
-- Feature Engineering

-- time_of_day
select
time,
(case
when time between '00:00:00' and '12:00:00' then 'Morning'
when time between '12:01:00' and '16:00:00' then 'Afternoon'
else 'Evening'
end) as time_of_day 
from sales;

alter table sales add column time_of_day varchar(20);

update sales
set time_of_day = (

case
when time between '00:00:00' and '12:00:00' then 'Morning'
when time between '12:01:00' and '16:00:00' then 'Afternoon'
else 'Evening'
end
);

-- day name
select
date,
dayname(date) as day_name
from sales;

alter table sales add column day_name varchar(10);

update sales
set day_name = dayname(date);

-- month_name
select
date,
monthname(date) as month_name
from sales;

alter table sales add column month_name varchar(10);

update sales
set month_name = monthname(date);
-- ----------------------------------------------------

-- -------------------------------------------------------
-- ------------------ Generic ----------------------------

-- How many unique cities does the data have?

select
distinct city
from sales;

-- In which city is each branch?
select
distinct city,
branch
from sales;
-- Ans: Branch A is in Yangon, Branch B is in Mandalay, and Branch C is in Naypyitwaw.
-- -------------------------------------------------------

-- -------------------------------------------------------
-- -------------------- Product --------------------------

-- How many unique product lines does the data have?
select
count(distinct product_line) as num_product_lines
from sales;
-- Ans: There are 6 unique product lines in the data.
-- ---------------------------------------------------------------------
-- What is the most common payment method?
select
payment_method
from sales
group by payment_method
order by count(*) desc
limit 1;
-- Ans: The most common payment method is cash
-- -------------------------------------------------------------------
-- What is the most selling product line?

-- Notes:
-- Find the sum of the total column, grouped by each product_line

-- Query:
select
product_line
from sales
group by product_line
order by sum(total) desc
limit 1;
-- Ans: The most selling product line is Food and Beverages
-- ------------------------------------------------------------------
-- What is the total revenue by month?

-- Notes:
-- group by month
-- aggregate sum of total column

-- Query:
select
month_name,
sum(round(total,2)) as total_revenue
from sales
group by month_name
order by total_revenue desc;
-- Ans: Data from only January, February, and March can be found from the dataset. January generated the highest revenue while February generated the lowest.
-- --------------------------------------------------------------------
-- What month had the largest COGS?

-- Notes:
-- group by month
-- aggreagate sum of cogs column
-- descending order, limit to 1 the top value.

-- Query:
select
month_name
from sales
group by month_name
order by sum(cogs) desc
limit 1;
-- Ans: January had the largest COGS.
-- ---------------------------------------------------------------------
-- What product line had the largest revenue?

-- Notes:
-- group by product_line column
-- aggregate sum of total column
-- limit to 1 for top value

-- Query:
select
product_line
from sales
group by product_line
order by sum(total) desc
limit 1;
-- Ans: The Food and Beverages product line had the largest revenue.
-- -------------------------------------------------------------------------
-- What is the city with the largest revenue?

-- Notes:
-- group by city column
-- aggregate sum of total column

-- Query:
select
city
from sales
group by city
order by sum(total) desc
limit 1;
-- Ans: Naypyitaw is the city with the largest revenue.
-- -----------------------------------------------------------------------------
-- What product line had the largest VAT?

-- Notes:
-- group the product_line column
-- aggregate sum of VAT
-- limit of 1 to find the top value

-- Query:
select
product_line
from sales
group by product_line
order by sum(VAT) desc
limit 1;
-- Ans: The Food and Beverages product line had the largest VAT incurred.
-- ------------------------------------------------------------------------------
-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

-- Notes:
-- find aggregate sum of sales per product line.
-- use aggregate avg to find average sales.
-- use a case statement to create conditions

-- Query:
select
product_line,
case
when avg(total) > (select avg(total) from sales) then 'Good'
else 'Bad' end as sales_rating
from sales
group by product_line;
-- Ans: Fashion Accessories and Electronic Accessories are the only product_lines with a bad sales_rating
-- ---------------------------------------------------------------------------------------
-- Which branch sold more products than average product sold?

-- Notes:
-- find total quantity sold by each branch
-- find avg quantity sold by the branches
-- create condition to filter out branches that sold higher than the average

-- Query:
with t1 as (
select
branch,
sum(quantity) as total_sold
from sales
group by branch
)

select 
branch
from t1
where total_sold > (select avg(total_sold) from t1); 
-- Ans: Branches A and C sold more products than the average products sold (categorized by branch)
-- ------------------------------------------------------------------------------------------------
-- What is the most common product line by gender?

-- Notes:
-- Assume 'common' means the highest number of orders, or count of invoice_id,
-- separate row for Male and Females
-- use aggregate count

-- Query:
with male as
(select
gender,
product_line,
count(*) as total
from sales
where gender = 'Male'
group by product_line),

female as (
select
gender,
product_line,
count(*) as total
from sales
where gender = 'Female'
group by product_line)

select
gender,
product_line
from male
where total = (select max(total) from male)
union all
select
gender,
product_line
from female
where total = (select max(total) from female);
-- Ans: The most common product for Females is Fashion Accessories and the most common product for males is Health and beauty.
-- -----------------------------------------------------------------------------------------------------------------------------
-- What is the average rating of each product line?

-- Notes:
-- take aggregate average of rating column
-- group by product_line column

-- Query:
select
product_line,
round(avg(rating),1) as average_rating
from sales
group by product_line
order by average_rating desc;
-- Ans: Food and beverages have the highest rating with 7.1, while Home and lifestyle has the lowest rating at 6.8.
-- -----------------------------------------------------------------------------------------------------------------


-- -----------------------------------------------------------------------------------------------------------------
-- ------------------------------------------ Sales ----------------------------------------------------------------

-- What is the number of sales made in each time of the day per weekday

-- Notes:
-- group by day_name and time_of_day columns
-- aggregate count of orders

-- Query:
select
day_name,
time_of_day,
count(*) as count_of_sales
from sales
group by day_name, time_of_day
order by day_name, time_of_day desc;
-- Ans: The highest number of sales were made on a Saturday evening.
-- ---------------------------------------------------------------------------
-- Which of the customer types brings the most revenue?

-- Notes:
-- group by customer_type column
-- use aggregate sum of total revenue column

-- Query:
select
customer_type
from sales
group by customer_type
order by sum(total) desc limit 1;
-- Ans: The members bring the most member out of the two customer types.
-- --------------------------------------------------------------------------------------
-- Which city has the largest tax percent / VAT (Value Added Tax)?

-- Notes:
-- Assume that we are looking for total VAT for each city and comparing which total was the highest
-- group by city column
-- aggregate sum of VAT column

-- Query:
select
city
from sales
group by city
order by sum(VAT) desc limit 1;
-- Ans: Naypjtaw had the largest VAT out of all cities in the dataset.
-- ------------------------------------------------------------------------------------------------------
-- Which customer type pays the most in VAT?

-- Query:
select
customer_type
from sales
group by customer_type
order by sum(VAT) desc limit 1;
-- Ans: The Member customer_type paid the most in VAT.
-- ----------------------------------------------------------------------------------------------------------


-- ----------------------------------------------------------------------------------------------------------
-- ------------------------------------ Customer ------------------------------------------------------------

--  How many unique customer types does the data have?
select
count(distinct customer_type) as n_customer_type
from sales;
-- Ans: The data has 2 unique customer types.
-- -----------------------------------------------------------------------------------------------------------
-- How many unique payment methods does the data have?
select
count(distinct payment_method) as n_payment_method
from sales;
-- Ans: There are 3 unique payment methods in the data.
-- ------------------------------------------------------------------------------------------------------------
-- What is the most common customer type?
select
customer_type
from sales
group by customer_type
order by count(*) desc limit 1;
-- Ans: The member customer type is the most common customer type.
-- --------------------------------------------------------------------------------------------------------------
-- Which customer type buys the most?

-- Notes:
-- Assume customer that buys the most is the one that buys the highest quantity of products.

-- Query:
select
customer_type
from sales
group by customer_type
order by sum(quantity) desc limit 1;
-- Ans: The member customer type buys the most products.
-- ---------------------------------------------------------------------------------------------------------------------
-- What is the gender of most of the customers?
select
gender
from sales
group by gender
order by count(*) desc limit 1;
-- Ans: Most of the customers are male.
-- -----------------------------------------------------------------------------------------------------------------------
-- What is the gender distribution per branch?

-- Notes:
-- group by branch
-- calculate aggregate percentage of gender

-- Query:
select
branch,
round((sum(case when gender = 'Male' then 1 else 0 end) / count(*))*100,2) as male_pct,
round((sum(case when gender = 'Female' then 1 else 0 end) / count(*))*100,2) as female_pct
from sales
group by branch;
-- Ans: Branch A has the highest male percentage while Branch C has the highest female percentage.
-- ---------------------------------------------------------------------------------------------------------------------------------
-- Which time of the day do customers give most ratings?

-- Notes:
-- Assume you are finding the highest average ratings
-- group by time_of_day
-- aggregate average of ratings
-- order by average desc

-- Query:
select
time_of_day
from sales
group by time_of_day
order by avg(rating) desc limit 1;
-- Ans: On average, customers give higher ratings in the afternoon.
-- -------------------------------------------------------------------------------------------------------------------------
-- Which time of the day do customers give most ratings per branch?

-- Notes:
-- Assume we are finding the highest average ratings
-- group by both branch and time_of_day columns
-- find aggregate averagem order by average descending

-- Query:
with t1 as (
select
branch,
time_of_day,
avg(rating) as avg_rating
from sales
group by branch, time_of_day
)
select
branch,
time_of_day,
avg_rating
from t1
where (branch, avg_rating) in (
select
branch,
max(avg_rating) as highest_rating
from t1
group by branch)
order by branch asc;
-- Ans: Branch A gets the best ratings in the afternoon, Branch B gets the best ratings in the morning, and Branch C gets the best ratings in the evening.
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Which day of the week has the best avg ratings?

-- Notes:
-- group by day_name
-- order by aggregate average descending

-- Query:
select
day_name
from sales
group by day_name
order by avg(rating) desc limit 1;
-- Ans: Monday has the best average ratings.
-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------











    
    