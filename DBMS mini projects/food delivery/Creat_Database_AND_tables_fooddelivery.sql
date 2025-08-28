-- DROP DATABASE IF EXISTS `Food Delivery Management System`;
-- CREATE DATABASE `Food Delivery Management System`;
USE `Food Delivery Management System`;
-- Assignment: Aggregate Functions & GROUP BY – Food Delivery Application
-- You are working as a backend data analyst for a food delivery application. Your database has the following core tables:
-- Table Structures
-- Customers
-- Column      DataType  Description
-- customer_id INT (PK)  Unique customer ID
-- name        VARCHAR   Customer name
-- city        VARCHAR   Customer’s city

CREATE TABLE Customers
(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(50),
customer_city VARCHAR(60)
);

DROP TABLE Customers;

-- Restaurants
-- Column        DataType  Description
-- restaurant_id INT (PK)  Unique restaurant ID
-- name          VARCHAR   Restaurant name
-- city          VARCHAR   Location
-- cuisine_type  VARCHAR   e.g., Indian, Chinese, Italian

CREATE TABLE Restaurants
(
restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
restaurant_name VARCHAR(50),
restaurant_city VARCHAR(60),
cuisine_type VARCHAR(100)
);

DROP TABLE Restaurants;

-- Orders
-- Column        DataType  Description
-- order_id      INT (PK)  Unique order ID
-- customer_id   INT (FK)  Linked to Customers
-- restaurant_id INT (FK)  Linked to Restaurants
-- order_amount  DECIMAL   Total value of the order
-- order_date    DATE      Date of the order

CREATE TABLE Orders
(
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT REFERENCES Customers(customer_id),
restaurant_id INT REFERENCES Restaurants(restaurant_id),
order_amount DECIMAL(10,2),
order_date DATETIME
);

DROP TABLE Orders;