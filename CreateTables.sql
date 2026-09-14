create table customers (
	primary key(CustomerID)
);

create table products (
	primary key(ProductID)
);

create table orders (
primary key(OrderID),
foreign key (CustomerID) references customers(CustomerID),
foreign key(ProductID) references products(ProductID)
);

create table payments(
primary key(PaymentID),
foreign key (OrderID) references orders(OrderID)
)
