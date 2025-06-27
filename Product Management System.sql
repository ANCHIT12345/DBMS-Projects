-- DROP DATABASE IF EXISTS `Product_Management`;
-- CREATE DATABASE `Product_Management`;
-- USE `Product_Management`;

-- Tables to Use:

-- - Products (product_id, name, category, price, stock)
CREATE TABLE Products
(
product_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
category VARCHAR(100) NOT NULL DEFAULT 'Unknown',
price DECIMAL(10,2) NOT NULL DEFAULT 0,
stock INT DEFAULT 0
);

DROP TABLE Products;

-- - Customers (customer_id, name, email, city, join_date)
CREATE TABLE Customers
(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
email VARCHAR(650) NOT NULL,
CHECK (email LIKE '___%@___%.__%'),
city VARCHAR(60) NOT NULL DEFAULT 'Unknown',
join_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
);

DROP TABLE Customers;

-- - Orders (order_id, product_id, customer_id, order_date, quantity, total_amount, delivery_status)
CREATE TABLE Orders
(
order_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
FOREIGN KEY (product_id) REFERENCES Products(product_id),
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
order_date  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
quantity INT NOT NULL DEFAULT 1,
total_amount DECIMAL(10,2) DEFAULT NULL,
delivery_status ENUM('Deliverd','Shipped','Pending','Out For Delivery','On Hold')
);

DROP TABLE Orders;

-- Part 1: CREATE (Insert Records)
-- Task 1: Insert Operations
-- 1.       Insert a new product named “Wireless Mouse” into the Products table.
INSERT INTO Products(name, category, price, stock)
VALUES 
('Wireless Mouse', 'wireless device', 2999, 1988),
('Bluetooth Keyboard', 'wireless device', 3499, 1520),
('USB-C Hub', 'computer accessory', 2599, 875),
('Gaming Headset', 'audio device', 5999, 420),
('Laptop Stand', 'office accessory', 1799, 300),
('Portable SSD 1TB', 'storage device', 6999, 250),
('Smartwatch Series 5', 'wearable', 8999, 180),
('Noise Cancelling Earbuds', 'audio device', 4999, 615),
('4K Webcam', 'camera device', 4299, 330),
('Mechanical Keyboard', 'wired device', 5499, 740),
('Wireless Charger Pad', 'wireless device', 1999, 920);

SELECT * FROM Products;

-- 2.       Add three new customers from different cities in a single query.
INSERT INTO Customers(name, email, city, join_date)
VALUES 
('Ravi Kumar', 'ravi.kumar@example.com', 'Delhi', '2025-06-25 10:30:00'),
('Anita Sharma', 'anita_sharma123@mail.com', 'Mumbai', '2025-06-26 14:15:00'),
('John Dsouza', 'john.d.souza@test.org', 'Goa', '2025-06-27 09:45:00'),
('Meera Nair', 'meera.nair89@mail.com', 'Kochi', '2025-06-24 11:00:00'),
('Sandeep Yadav', 'sandy.yadav@test.com', 'Jaipur', '2025-06-23 13:20:00'),
('Priya Desai', 'priya.desai@example.org', 'Ahmedabad', '2025-06-22 15:50:00'),
('Karan Mehta', 'karan.mehta@demo.com', DEFAULT, DEFAULT),
('Aisha Khan', 'aisha.khan99@mail.net', DEFAULT, DEFAULT),
('Vikram Roy', 'vikram.roy123@example.com', 'Bangalore', '2025-06-26 08:45:00'),
('Neha Sinha', 'neha_sinha@sample.org', DEFAULT, DEFAULT),
('Rahul Verma', 'rahul.verma@mail.org', 'Pune', '2025-06-25 12:10:00'),
('Deepa Joshi', 'deepa.joshi88@mail.com', DEFAULT, DEFAULT),
('Arjun Iyer', 'arjun.iyer@testmail.com', DEFAULT, DEFAULT);

SELECT * FROM Customers;

-- 3.       Add five new orders with various products and customers into the Orders table.
INSERT INTO Orders(product_id, customer_id, order_date, quantity, total_amount, delivery_status)
VALUES 
(1, 5, '2025-06-26 11:15:00', 2, 5998.00, 'Shipped'),
(7, 2, '2025-06-25 17:30:00', 1, 8999.00, 'Out For Delivery'),
(3, 10, '2025-06-27 09:00:00', 3, 7797.00, 'Pending'),
(9, 1, '2025-06-24 10:10:00', 1, 4299.00, 'Deliverd'),
(4, 8, '2025-06-26 14:45:00', 2, 11998.00, 'On Hold');

SELECT * FROM Orders;

-- Part 2: READ (Retrieve Data)
-- Task 2: Query Operations
-- 4.       Fetch all products priced above ₹1,000.

SELECT * FROM Products WHERE price > 1000;

-- 5.       Get the list of customers who joined in the last 30 days.

SELECT DATEDIFF(NOW(),join_date) datediffrance , Customers.* FROM Customers WHERE DATEDIFF(NOW(),join_date)<30;

-- 6.       Display all orders placed by customer “Rohit Mehra”.

SELECT * FROM Customers WHERE (SELECT customer_id FROM Customers WHERE name = 'Rohit Mehra');

-- 7.       List all orders where delivery status is still 'Pending'.

SELECT * FROM Orders WHERE delivery_status = 'Pending';

-- 8.       Get all products that belong to the 'Electronics' category and contain the word 'Wireless' in their name.

INSERT INTO Products(name, category, price, stock)
VALUES 
('Wireless Bluetooth Speaker', 'electronics', 3499, 620),
('Smart LED TV 43 Inch', 'electronics', 28999, 85);

SELECT * FROM Products WHERE name LIKE '%Wireless%' AND category = 'Electronics';

-- ✅ Part 3: UPDATE (Modify Data)
-- Task 3: Update Operations
-- 9.       Add a new column stock_status to Products table and set its default value to 'In Stock'.

ALTER TABLE Products 
ADD COLUMN stock_status ENUM('In Stock', 'Out Of Stock') NOT NULL DEFAULT 'In Stock';

SELECT * FROM Products WHERE stock_status = 'In Stock';

UPDATE Products SET stock_status = 'In Stock';

-- 10.   Update the stock_status to 'Out of Stock' where stock is 0.

INSERT INTO Products(name, category, price, stock, stock_status)
VALUES 
('Portable SSD 512GB', 'storage', 4999, 0, DEFAULT),
('External HDD 1TB', 'storage', 3999, 0, DEFAULT),
('USB 3.1 Flash Drive 128GB', 'storage', 1099, 0, DEFAULT),
('NVMe M.2 SSD 1TB', 'storage', 7499, 0, DEFAULT),
('MicroSD Card 64GB', 'storage', 799, 0, DEFAULT);

SELECT * FROM Products WHERE stock = 0;
UPDATE Products SET stock_status = 'Out Of Stock' WHERE stock = 0;

-- 11.   Add a new column loyalty_status to Customers table and set all values to 'Regular'.

ALTER TABLE Customers 
ADD COLUMN loyalty_status ENUM('New', 'Regular', 'Returning', 'Frequent','Loyal', 'VIP', 'Inactive', 'Guest', 'Suspended', 'Blacklisted') DEFAULT 'New';

SELECT * FROM Customers;
UPDATE Customers SET loyalty_status = 'Regular';

-- 12.   Copy the name of each product to a new column product_name_backup.

ALTER TABLE Products 
ADD COLUMN product_name_backup VARCHAR(100);

SELECT * FROM Products;
UPDATE Products SET product_name_backup = name;

-- Part 4: DELETE (Remove Records)
-- Task 4: Delete Operations
-- 13.   Delete all products from the Products table whose names contain the word “Sample”.

INSERT INTO Products(name, category, price, stock)
VALUES 
('Sample Power Bank 10000mAh', 'electronics', 1599, 120);

SELECT * FROM Products WHERE name LIKE '%Sample%';
DELETE FROM Products WHERE name LIKE '%Sample%';
SELECT * FROM Products;

-- 14.   Remove all orders dated between '2023-01-01' and '2023-06-30'.

INSERT INTO Customers(name, email, city, join_date)
VALUES 
('Aman Joshi', 'aman.joshi@example.com', 'Delhi', '2023-02-15 11:30:00'),
('Sara Khan', 'sara.khan@mail.com', 'Hyderabad', '2023-06-10 09:20:00'),
('Rohit Verma', 'rohit.verma@test.org', 'Chennai', '2023-11-05 17:45:00'),
('Tanya Mehra', 'tanya.mehra@sample.net', 'Bangalore', '2024-01-12 13:00:00'),
('Imran Sheikh', 'imran.sheikh@mail.org', 'Kolkata', '2024-07-25 08:50:00');
SELECT * FROM Customers;

INSERT INTO Orders(product_id, customer_id, order_date, quantity, total_amount, delivery_status)
VALUES 
(2, 14, '2023-01-18 10:45:00', 1, 3499.00, 'Deliverd'),
(5, 18, '2023-02-10 14:30:00', 2, 3598.00, 'Deliverd'),
(1, 17, '2023-03-22 09:15:00', 1, 2999.00, 'Deliverd'),
(7, 15, '2023-05-05 16:00:00', 1, 8999.00, 'Deliverd'),
(4, 16, '2023-06-12 11:20:00', 3, 17997.00, 'Deliverd');
SELECT * FROM Orders;

SELECT * FROM Orders WHERE order_date BETWEEN '2023-01-01' AND '2023-06-30';
DELETE FROM Orders WHERE order_date BETWEEN '2023-01-01' AND '2023-06-30';

-- 15.   Delete customers whose city is in ('Oldcity', 'DemoTown', 'TestArea').
INSERT INTO Customers(name, email, city, join_date)
VALUES 
('Ritika Shah', 'ritika.shah@example.com', 'Oldcity', '2024-02-14 10:25:00'),
('Nikhil Rana', 'nikhil.rana@testmail.com', 'DemoTown', '2024-08-30 15:10:00'),
('Shruti Jain', 'shruti.jain@mail.org', 'TestArea', '2025-01-12 09:00:00'),
('Manoj Pillai', 'manoj.pillai@sample.com', 'Oldcity', '2025-03-03 13:45:00'),
('Ayesha Ali', 'ayesha.ali@demo.org', 'DemoTown', '2024-12-20 18:35:00');
SELECT * FROM Customers;

SELECT * FROM Customers WHERE city IN('Oldcity', 'DemoTown', 'TestArea');
DELETE FROM Customers WHERE city IN('Oldcity', 'DemoTown', 'TestArea');


-- 16.   Remove products not in categories 'Electronics', 'Fashion', 'Home Decor'.

INSERT INTO Products(name, category, price, stock)
VALUES 
('Wireless Earbuds Pro', 'Electronics', 4999, 250),
('Smartphone Tripod Stand', 'Electronics', 1299, 180),
('Casual Denim Jacket', 'Fashion', 2399, 95),
('Leather Wallet - Men', 'Fashion', 999, 300),
('Wooden Wall Clock', 'Home Decor', 1599, 60),
('Decorative Table Lamp', 'Home Decor', 1899, 45);
SELECT * FROM Products;

SELECT * FROM Products WHERE category NOT IN ('Electronics', 'Fashion', 'Home Decor');
DELETE FROM Products WHERE category NOT IN ('Electronics', 'Fashion', 'Home Decor');

SELECT * FROM Orders;
SELECT * FROM Orders WHERE product_id IN (SELECT product_id FROM Products WHERE category NOT IN ('Electronics', 'Fashion', 'Home Decor'));
DELETE FROM Orders WHERE product_id IN (SELECT product_id FROM Products WHERE category NOT IN ('Electronics', 'Fashion', 'Home Decor'));







