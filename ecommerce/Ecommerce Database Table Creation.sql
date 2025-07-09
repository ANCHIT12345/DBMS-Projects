CREATE DATABASE E_commerce_Databases;

USE E_commerce_Databases;

--·         Customers (customer_id, name, city)

CREATE TABLE Customers
(
customer_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(50),
city VARCHAR(100)
);

--·         Orders (order_id, customer_id, order_date, total_amount)

CREATE TABLE Orders
(
order_id INT PRIMARY KEY IDENTITY(1,1),
customer_id INT REFERENCES Customers(customer_id),
order_date DATETIME,
total_amount DECIMAL(10,2)
);

--·         Products (product_id, name, category, price)

CREATE TABLE Products
(
product_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(100),
category VARCHAR(100),
price DECIMAL(10,2)
);

--·         Order_Items (order_item_id, order_id, product_id, quantity)

CREATE TABLE Order_Items
(
order_item_id INT PRIMARY KEY IDENTITY(1,1),
order_id INT REFERENCES Orders(order_id),
product_id INT REFERENCES Products(product_id),
quantity INT
);

--·         Suppliers (supplier_id, name, product_id)

CREATE TABLE Suppliers
(
supplier_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(50),
product_id INT REFERENCES Products(product_id)
)





