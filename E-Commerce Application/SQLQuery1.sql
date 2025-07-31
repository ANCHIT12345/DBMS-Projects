--Assignment: Indexes in E-Commerce Application

CREATE DATABASE E_Commerce_Application;
USE E_Commerce_Application;

--Context:

--You are working as a database developer for an e-commerce platform. The platform has the following tables:

--Users(UserID, FullName, Email, City, JoinDate)

CREATE TABLE Users
(
UserID INT PRIMARY KEY IDENTITY(1,1),
FullName VARCHAR(50),
Email VARCHAR(320),
CONSTRAINT chk_email CHECK(Email LIKE '___%@___%.__%'),
City VARCHAR(60),
JoinDate DATE
);

SELECT * FROM Users;

--Products(ProductID, ProductName, Category, Price, Stock)

CREATE TABLE Products
(
ProductID INT PRIMARY KEY IDENTITY(1,1),
ProductName VARCHAR(100),
Category VARCHAR(100),
Price DECIMAL(10,2),
Stock INT
);

SELECT * FROM Products;

--Orders(OrderID, UserID, OrderDate, TotalAmount, PaymentMode)

CREATE TABLE Orders
(
OrderID INT PRIMARY KEY IDENTITY(1,1),
UserID INT REFERENCES Users(UserID),
OrderDate DATE,
TotalAmount DECIMAL(10,2),
PaymentMode VARCHAR(15)
);

SELECT * FROM Orders;

--OrderItems(OrderItemID, OrderID, ProductID, Quantity, PricePerUnit)

CREATE TABLE OrderItems
(
OrderItemID INT PRIMARY KEY IDENTITY(1,1),
OrderID INT REFERENCES Orders(OrderID),
ProductID INT REFERENCES Products(ProductID),
Quantity INT,
PricePerUnit DECIMAL(10,2),
);

SELECT * FROM OrderItems;

--Assignment Tasks

--1. Understanding Indexes & Why They Matter

--Q1. Write down 3 scenarios in this database where adding an index would improve query performance.

--→ Hint: Think about frequent searches, filters, or joins.

--Answers
--Filtering or searching orders by userid
--Joining OrderItems and Products
--Searching Users by Email

--2. Creating Indexes

--Q2. Create an index on the Email column of the Users table to speed up login and lookup.

CREATE INDEX index_user_email ON Users(Email);

---- Write your SQL query here

--Q3. Create an index on the Category column of the Products table to improve performance for category-wise filtering.

CREATE INDEX index_products_category ON Products(Category);

SELECT * FROM Products WHERE Category = 'Electronics';

--3. Single-column vs Multi-column Index

--Q4. Create a single-column index on the UserID column in the Orders table.

CREATE INDEX index_orders_userid ON Users(UserID);

SELECT * FROM Users;

--Q5. Create a multi-column index on (UserID, OrderDate) in the Orders table and explain when it is useful.

CREATE INDEX index_orders ON Orders(UserID, OrderDate);

SELECT * FROM Orders WHERE UserID = 42 AND OrderDate >= '2024-01-01';

SELECT * FROM Orders WHERE UserID = 42 ORDER BY OrderDate DESC;

--4. Unique Indexes

--Q6. Create a unique index on the Email column in the Users table to prevent duplicate registrations.

CREATE UNIQUE INDEX index_users_email_unique ON Users(Email);

SELECT Email, COUNT(*) FROM Users GROUP BY Email HAVING COUNT(*) >1;

--5. Clustered vs Non-clustered Index (Conceptual)

--Q7. Explain which column(s) would benefit more from non-clustered indexes in the Products or OrderItems table.

-- Category AND OrderID IN Product Table
-- ProductID in orderItems

--6. Dropping Indexes

--Q8. Drop the index on the Category column of the Products table if it’s not useful anymore.

DROP INDEX index_products_category ON Products;

SELECT name FROM sys.indexes WHERE object_id = OBJECT_ID('Products');

--7. Performance Tradeoffs

--Q9. Insert 1000 fake records into the Orders table and measure the time it takes with and without indexes on UserID.

SET STATISTICS TIME ON;
--Completion time: 2025-07-31T14:47:04.0738755+05:30

SET STATISTICS TIME OFF;

--→ Explain what performance tradeoff you observed.
--it takes a long time to insert any data when index is still up on a perticular table and increases the insert time by a lot