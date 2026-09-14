CREATE TABLE customers (
	customer_id INT,
    age INT,
    city TEXT,
    signup_date DATETIME,
    PRIMARY KEY(customer_id)
);

CREATE TABLE products (
	product_id INT,
    product_name TEXT,
    category TEXT,
    unit_price DOUBLE,
	PRIMARY KEY(product_id)
);

CREATE TABLE orders (
	order_id INT,
	order_date DATETIME,
	quantity INT,
	discount DOUBLE,
	payment_method TEXT,
	status TEXT,
	PRIMARY KEY(order_id),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY(product_id) REFERENCES products(product_id)
);

CREATE TABLE payments(
	payment_id INT,
	payment_date DATETIME,
	payment_status TEXT,
	PRIMARY KEY(payment_id),
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
)
