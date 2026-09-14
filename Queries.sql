/*
Author: Kate Passwater
Purpose: Practice developing SQL queries in business applications
*/

-- GENERAL COUNTS
select count(payment_id) from payments;
select count(order_id) from orders;
select count(customer_id) from customers;
select count(product_id) from products;

 -- CUSTOMER TABLE QUERIES

-- how many customers from each age
select age, count(age) from customers group by age order by age asc;

-- which age group has the most customers (18-29, 30-49, 50 +)
select
	case
		when age >= 18 and age < 30 then '18-29'
        when age >= 30 and age < 50 then '30-49'
        else '50+'
	end as age_group,
    count(*) as total_count
from customers group by age_group order by total_count desc;

-- what cities are customers from
select city, count(city) from customers group by city order by count(city) desc;

-- what is the most popular customer segment?
select customer_segment, count(customer_segment) as count from customers group by customer_segment order by count desc;

-- how many sign ups per month
select month(signup_date) as month, count(month(signup_date)) as count from customers group by month order by month asc;

-- which 3 months have the highest number of sign ups
select month(signup_date) as month, count(month(signup_date)) as count from customers group by month order by count desc limit 3;

-- which 3 months did the most VIPs sign up
select month(signup_date) as month, count(month(signup_date)) as count from customers where customer_segment = "VIP" group by month order by count desc limit 3;

-- ORDER TABLE QUERIES

-- how many orders had discounts applied
select discount, count(discount) as count from orders group by discount order by discount asc;

-- what is the most popular payment method
select payment_method, count(payment_method) as count from orders group by payment_method order by count desc;

-- PRODUCT TABLE QUERIES

-- how many categories of products are there
select category, count(category) as count from products group by category;

-- which items are in each category
select product_name, category from products order by category;

-- PAYMENTS TABLE QUERIES

-- how many of each payment status
select payment_status, count(payment_status) as count from payments group by payment_status order by count desc;

-- number of payments per month
select month(payment_date) as month, count(month(payment_date)) as count from payments group by month order by month asc;

-- which 3 months have the highest number of payments
select month(payment_date) as month, count(month(payment_date)) as count from payments group by month order by count desc limit 3;

/* FUTURE QUESTIONS:
which customer segments have the most discounts
which payment method is most popular?
which payment method is most popular for new customers?
which payment method is most popular for each age group?
how many categories of products?
how many items are returned?
how many items are returned by new customers vs vip customers?
what is the most popular product?
what category is most popular for each age group?
what product is most popular for each age group?

*/