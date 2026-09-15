/*
Author: Kate Passwater
Purpose: Practice developing SQL queries in business applications
*/

-- GENERAL COUNTS
SELECT COUNT(payment_id) FROM payments;
SELECT COUNT(order_id) FROM orders;
SELECT COUNT(customer_id) FROM customers;
SELECT COUNT(product_id) FROM products;

 -- CUSTOMER TABLE QUERIES

-- how many customers from each age
SELECT age, COUNT(age) FROM customers GROUP BY age ORDER BY age ASC;

-- which age group has the most customers (18-29, 30-49, 50 +)
SELECT
	CASE
		WHEN age >= 18 AND age < 30 THEN '18-29'
        WHEN age >= 30 AND age < 50 THEN '30-49'
        ELSE '50+'
	END AS age_group,
    COUNT(*) AS total_count
FROM customers GROUP BY age_group ORDER BY total_count DESC;

-- what cities are customers from
SELECT city, COUNT(city) FROM customers GROUP BY city ORDER BY COUNT(city) DESC;

-- what is the most popular customer segment?
SELECT customer_segment, COUNT(customer_segment) AS count FROM customers GROUP BY customer_segment ORDER BY count DESC;

-- how many sign ups per month
SELECT MONTH(signup_date) AS month, COUNT(MONTH(signup_date)) AS count FROM customers GROUP BY month ORDER BY month ASC;

-- which 3 months have the highest number of sign ups
SELECT MONTH(signup_date) AS month, COUNT(MONTH(signup_date)) AS count FROM customers GROUP BY month ORDER BY count DESC LIMIT 3;

-- which 3 months did the most VIPs sign up
SELECT MONTH(signup_date) AS month, COUNT(MONTH(signup_date)) AS count FROM customers WHERE customer_segment = "VIP" GROUP BY month ORDER BY count DESC LIMIT 3;

-- ORDER TABLE QUERIES

-- how many orders had discounts applied
SELECT discount, COUNT(discount) AS count FROM orders GROUP BY discount ORDER BY discount ASC;

-- what is the most popular payment method
SELECT payment_method, COUNT(payment_method) AS count FROM orders GROUP BY payment_method ORDER BY count DESC;

-- how many orders are returned
SELECT status, COUNT(status) AS count FROM orders GROUP BY status;

-- PRODUCT TABLE QUERIES

-- how many categories of products are there
SELECT category, COUNT(category) AS count FROM products GROUP BY category;

-- which items are in each category
SELECT product_name, category FROM products ORDER BY category;

-- PAYMENTS TABLE QUERIES

-- how many of each payment status
SELECT payment_status, COUNT(payment_status) AS count FROM payments GROUP BY payment_status ORDER BY count DESC;

-- number of payments per month
SELECT MONTH(payment_date) AS month, COUNT(MONTH(payment_date)) AS count FROM payments GROUP BY month ORDER BY month ASC;

-- which 3 months have the highest number of payments
SELECT MONTH(payment_date) AS month, COUNT(MONTH(payment_date)) AS count FROM payments GROUP BY month ORDER BY count DESC LIMIT 3;


-- QUERIES INVOLVING JOIN

-- which customer segments have the most discounts
SELECT COUNT(discount) AS count, customer_segment FROM (SELECT discount, customer_segment FROM orders JOIN customers ON orders.customer_id = customers.customer_id) AS x GROUP BY customer_segment ORDER BY count DESC;

-- which customer segments have the higher discounts
SELECT customer_segment, COUNT(customer_segment) AS count, discount FROM (SELECT discount, customer_segment FROM orders JOIN customers ON orders.customer_id = customers.customer_id) AS x GROUP BY customer_segment, discount ORDER BY customer_segment;

-- which payment method is most popular for new customers?
SELECT payment_method, COUNT(payment_method) AS count FROM payments INNER JOIN orders ON payments.order_id = orders.order_id INNER JOIN customers ON customers.customer_id = orders.customer_id WHERE customer_segment = "New" GROUP BY payment_method;

-- which payment method is most popular for each age group?
SELECT 
	CASE
		WHEN age >= 18 AND age < 30 THEN '18-29'
        WHEN age >= 30 AND age < 50 THEN '30-49'
        ELSE '50+'
	END AS age_group, payment_method, COUNT(payment_method) AS count FROM customers RIGHT JOIN orders ON customers.customer_id = orders.customer_id WHERE payment_method != "" GROUP BY age_group, payment_method ORDER BY age_group, count DESC;

-- how many items are returned by new customers vs Regular customers vs VIP customers
SELECT customer_segment, COUNT(status) AS return_count FROM customers RIGHT JOIN orders ON customers.customer_id = orders.customer_id WHERE customer_segment != "" AND status = "Returned" GROUP BY customer_segment, status ORDER BY customer_segment;
    
-- what are the most popular products
SELECT COUNT(quantity) AS count, product_name FROM orders LEFT JOIN products ON orders.product_id = products.product_id GROUP BY product_name ORDER BY count DESC;

-- what is the most popular product
SELECT COUNT(quantity) AS count, product_name FROM orders LEFT JOIN products ON orders.product_id = products.product_id GROUP BY product_name ORDER BY count DESC LIMIT 1;

-- how much revenue is generated from the most popular product
SELECT product_name, count*unit_price AS total_revenue FROM (SELECT COUNT(quantity) AS count, product_name, unit_price FROM orders LEFT JOIN products ON orders.product_id = products.product_id GROUP BY product_name, unit_price ORDER BY count DESC LIMIT 1) AS x;


/* FUTURE QUESTIONS:
what category is most popular for each age group?
what product is most popular for each age group?
*/

