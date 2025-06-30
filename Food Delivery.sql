-- DROP DATABASE IF EXISTS `Food Delivery Management System`;
-- CREATE DATABASE `Food Delivery Management System`;
-- USE `Food Delivery Management System`;


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

-- INSERT DATE 
INSERT INTO Customers (customer_name, customer_city) VALUES
('Amit Sharma', 'Delhi'),
('Priya Singh', 'Mumbai'),
('Rahul Verma', 'Bangalore'),
('Sneha Patel', 'Ahmedabad'),
('Vikram Joshi', 'Pune'),
('Meera Nair', 'Kochi'),
('Sanjay Rao', 'Hyderabad'),
('Anita Das', 'Kolkata'),
('Rohan Mehta', 'Jaipur'),
('Divya Kulkarni', 'Nagpur'),
('Amit Sharma', 'Delhi'),
('Priya Singh', 'Delhi'),
('Rahul Verma', 'Delhi'),
('Sanjay Kapoor', 'Delhi'),
('Nisha Bhatia', 'Delhi'),
('Alok Mehra', 'Mumbai'),
('Meera Nair', 'Mumbai'),
('Vikram Joshi', 'Mumbai'),
('Pooja Shetty', 'Mumbai'),
('Rohan Kulkarni', 'Mumbai'),
('Sneha Patel', 'Ahmedabad'),
('Jay Shah', 'Ahmedabad'),
('Neha Desai', 'Ahmedabad'),
('Manish Modi', 'Ahmedabad'),
('Anita Parmar', 'Ahmedabad'),
('Sandeep Rao', 'Hyderabad'),
('Divya Reddy', 'Hyderabad'),
('Kiran Kumar', 'Hyderabad'),
('Lakshmi Iyer', 'Hyderabad'),
('Ravi Teja', 'Hyderabad'),
('Arjun Mehta', 'Jaipur'),
('Poonam Choudhary', 'Jaipur'),
('Sunil Yadav', 'Jaipur'),
('Komal Gupta', 'Jaipur'),
('Rakesh Sharma', 'Jaipur'),
('Tanvi Roy', 'Kolkata'),
('Sourav Banerjee', 'Kolkata'),
('Madhumita Das', 'Kolkata'),
('Arnab Ghosh', 'Kolkata'),
('Ritu Sen', 'Kolkata'),
('Ajay Thomas', 'Kochi'),
('Deepa Menon', 'Kochi'),
('Joseph Mathew', 'Kochi'),
('Reshma Nair', 'Kochi'),
('Anil George', 'Kochi'),
('Suraj Pawar', 'Pune'),
('Maya Patil', 'Pune'),
('Sameer Shinde', 'Pune'),
('Sheetal Gokhale', 'Pune'),
('Rajeev Salvi', 'Pune'),
('Vivek Tiwari', 'Bangalore'),
('Shweta Rao', 'Bangalore'),
('Harish Reddy', 'Bangalore'),
('Lakshmi S', 'Bangalore'),
('Ramesh Gowda', 'Bangalore'),
('Ashok Jain', 'Nagpur'),
('Kiran Borkar', 'Nagpur'),
('Smita Dhole', 'Nagpur'),
('Nilesh Katre', 'Nagpur'),
('Priya Khandekar', 'Nagpur'),
('Dev Sharma', 'Chandigarh'),
('Kavita Malhotra', 'Chandigarh'),
('Rohit Sethi', 'Chandigarh'),
('Simran Kaur', 'Chandigarh'),
('Tarun Arora', 'Chandigarh'),
('Yusuf Ali', 'Lucknow'),
('Reena Srivastava', 'Lucknow'),
('Mohit Mishra', 'Lucknow'),
('Asha Tiwari', 'Lucknow'),
('Raghav Saxena', 'Lucknow');


INSERT INTO Restaurants (restaurant_name, restaurant_city, cuisine_type) VALUES
('Spicy Villa', 'Delhi', 'North Indian'),
('Taste of Punjab', 'Mumbai', 'Punjabi'),
('Coastal Curries', 'Bangalore', 'Seafood'),
('Royal Thali', 'Ahmedabad', 'Gujarati'),
('Sizzler House', 'Pune', 'Continental'),
('Kerala Café', 'Kochi', 'South Indian'),
('Hyderabad Zaiqa', 'Hyderabad', 'Hyderabadi'),
('Bengal Delight', 'Kolkata', 'Bengali'),
('Jaipur Spice', 'Jaipur', 'Rajasthani'),
('Nagpur Bistro', 'Nagpur', 'Fast Food'),
('Spicy Villa', 'Delhi', 'North Indian'),
('Chopstick Express', 'Delhi', 'Chinese'),
('Taste of Punjab', 'Mumbai', 'Punjabi'),
('Urban Tadka', 'Mumbai', 'North Indian'),
('Royal Thali', 'Ahmedabad', 'Gujarati'),
('Street Bites', 'Ahmedabad', 'Fast Food'),
('Hyderabad Zaiqa', 'Hyderabad', 'Hyderabadi'),
('Biryani Bowl', 'Hyderabad', 'Mughlai'),
('Jaipur Spice', 'Jaipur', 'Rajasthani'),
('Pink City Dhaba', 'Jaipur', 'North Indian'),
('Bengal Delight', 'Kolkata', 'Bengali'),
('Mishti Hub', 'Kolkata', 'Sweets'),
('Kerala Café', 'Kochi', 'South Indian'),
('Seafood Harbour', 'Kochi', 'Seafood'),
('Sizzler House', 'Pune', 'Continental'),
('Pune Snacks', 'Pune', 'Fast Food'),
('Coastal Curries', 'Bangalore', 'Seafood'),
('Namma Oota', 'Bangalore', 'South Indian'),
('Nagpur Bistro', 'Nagpur', 'Multi-Cuisine'),
('Orange City Eats', 'Nagpur', 'Fast Food');

INSERT INTO Orders (customer_id, restaurant_id, order_amount, order_date) VALUES
(1, 2, 620.00, '2025-06-11 19:00:00'),
(3, 5, 450.00, '2025-06-12 20:20:00'),
(2, 1, 700.00, '2025-06-13 12:30:00'),
(4, 3, 350.00, '2025-06-14 14:45:00'),
(5, 7, 800.00, '2025-06-15 19:50:00'),
(1, 1, 450.00, '2025-06-01 13:45:00'),
(2, 2, 520.00, '2025-06-02 19:30:00'),
(3, 1, 330.00, '2025-06-03 12:15:00'),
(4, 2, 600.00, '2025-06-04 14:50:00'),
(5, 1, 290.00, '2025-06-05 20:10:00'),
(6, 3, 710.00, '2025-06-06 18:00:00'),
(7, 4, 490.00, '2025-06-07 12:45:00'),
(8, 3, 530.00, '2025-06-08 21:20:00'),
(9, 4, 640.00, '2025-06-09 15:10:00'),
(10, 3, 580.00, '2025-06-10 13:30:00'),
(11, 5, 300.00, '2025-06-11 16:15:00'),
(12, 6, 260.00, '2025-06-12 19:00:00'),
(13, 5, 410.00, '2025-06-13 20:45:00'),
(14, 6, 350.00, '2025-06-14 13:20:00'),
(15, 5, 280.00, '2025-06-15 14:30:00'),
(16, 7, 600.00, '2025-06-16 18:30:00'),
(17, 8, 720.00, '2025-06-17 20:15:00'),
(18, 7, 540.00, '2025-06-18 19:00:00'),
(19, 8, 680.00, '2025-06-19 12:50:00'),
(20, 7, 490.00, '2025-06-20 14:10:00'),
(21, 9, 370.00, '2025-06-21 15:45:00'),
(22, 10, 450.00, '2025-06-22 18:20:00'),
(23, 9, 390.00, '2025-06-23 19:40:00'),
(24, 10, 420.00, '2025-06-24 20:55:00'),
(25, 9, 310.00, '2025-06-25 13:35:00'),
(51, 19, 420.00, '2025-06-25 20:00:00'),
(52, 20, 380.00, '2025-06-26 13:10:00'),
(53, 19, 450.00, '2025-06-27 14:30:00'),
(54, 20, 330.00, '2025-06-28 15:50:00'),
(55, 19, 470.00, '2025-06-29 18:20:00'),
(56, 20, 290.00, '2025-06-30 19:40:00'),
(57, 19, 310.00, '2025-06-30 20:55:00'),
(58, 20, 240.00, '2025-06-30 21:45:00'),
(59, 19, 430.00, '2025-06-30 22:20:00'),
(60, 20, 260.00, '2025-06-30 23:15:00'),
(46, 19, 310.00, '2025-06-20 16:50:00'),
(47, 20, 260.00, '2025-06-21 18:05:00'),
(48, 19, 370.00, '2025-06-22 12:35:00'),
(49, 20, 290.00, '2025-06-23 14:55:00'),
(50, 19, 410.00, '2025-06-24 19:30:00'),
(41, 17, 480.00, '2025-06-15 19:00:00'),
(42, 18, 390.00, '2025-06-16 13:10:00'),
(43, 17, 570.00, '2025-06-17 20:25:00'),
(44, 18, 350.00, '2025-06-18 14:20:00'),
(45, 17, 430.00, '2025-06-19 15:40:00'),
(36, 15, 550.00, '2025-06-10 14:00:00'),
(37, 16, 280.00, '2025-06-11 16:15:00'),
(38, 15, 600.00, '2025-06-12 18:45:00'),
(39, 16, 320.00, '2025-06-13 12:30:00'),
(40, 15, 430.00, '2025-06-14 13:55:00'),
(31, 13, 400.00, '2025-06-05 12:20:00'),
(32, 14, 520.00, '2025-06-06 13:30:00'),
(33, 13, 390.00, '2025-06-07 15:40:00'),
(34, 14, 450.00, '2025-06-08 18:10:00'),
(35, 13, 470.00, '2025-06-09 19:25:00'),
(26, 11, 330.00, '2025-06-26 14:25:00'),
(27, 12, 220.00, '2025-06-27 16:40:00'),
(28, 11, 280.00, '2025-06-28 12:15:00'),
(29, 12, 190.00, '2025-06-29 13:50:00'),
(30, 11, 310.00, '2025-06-30 15:00:00'),
(1, 1, 430.00, '2022-02-12 14:35:00'),
(2, 2, 510.00, '2022-03-05 19:20:00'),
(3, 1, 310.00, '2022-06-15 13:50:00'),
(4, 2, 620.00, '2022-08-22 18:45:00'),
(5, 1, 470.00, '2022-10-10 20:10:00'),
(1, 2, 390.00, '2023-01-11 12:15:00'),
(2, 1, 540.00, '2023-04-03 14:25:00'),
(3, 2, 610.00, '2023-06-27 17:40:00'),
(4, 1, 280.00, '2023-08-18 11:30:00'),
(5, 2, 450.00, '2023-12-22 20:00:00'),
(6, 3, 550.00, '2022-02-21 13:10:00'),
(7, 4, 480.00, '2022-04-11 15:50:00'),
(8, 3, 370.00, '2022-06-18 20:25:00'),
(9, 4, 640.00, '2022-09-25 14:45:00'),
(10, 3, 530.00, '2022-12-15 19:05:00'),
(6, 4, 410.00, '2023-02-14 16:10:00'),
(7, 3, 620.00, '2023-05-20 13:35:00'),
(8, 4, 700.00, '2023-07-30 20:55:00'),
(9, 3, 470.00, '2023-10-06 18:00:00'),
(10, 4, 380.00, '2023-12-29 12:40:00'),
(11, 5, 340.00, '2022-03-03 14:15:00'),
(12, 6, 260.00, '2022-05-23 12:30:00'),
(13, 5, 410.00, '2022-07-29 16:50:00'),
(14, 6, 310.00, '2022-11-11 18:30:00'),
(15, 5, 290.00, '2023-01-07 20:40:00'),
(11, 6, 370.00, '2023-03-25 15:20:00'),
(12, 5, 280.00, '2023-06-17 19:10:00'),
(13, 6, 460.00, '2023-08-22 12:55:00'),
(14, 5, 330.00, '2023-10-14 14:45:00'),
(15, 6, 390.00, '2023-12-05 17:25:00'),
(16, 7, 690.00, '2022-01-15 13:40:00'),
(17, 8, 510.00, '2022-03-27 19:55:00'),
(18, 7, 430.00, '2022-05-18 12:25:00'),
(19, 8, 670.00, '2022-08-05 15:30:00'),
(20, 7, 590.00, '2022-10-21 20:45:00'),
(16, 8, 480.00, '2023-02-12 18:35:00'),
(17, 7, 610.00, '2023-05-01 13:20:00'),
(18, 8, 720.00, '2023-07-19 19:15:00'),
(19, 7, 540.00, '2023-09-28 14:05:00'),
(20, 8, 660.00, '2023-12-13 20:20:00'),
(21, 9, 370.00, '2022-02-17 15:10:00'),
(22, 10, 450.00, '2022-04-29 13:35:00'),
(23, 9, 390.00, '2022-06-14 19:50:00'),
(24, 10, 420.00, '2022-09-10 17:25:00'),
(25, 9, 310.00, '2022-11-27 20:05:00'),
(21, 10, 380.00, '2023-01-23 14:15:00'),
(22, 9, 430.00, '2023-04-04 13:30:00'),
(23, 10, 470.00, '2023-07-11 19:25:00'),
(24, 9, 390.00, '2023-09-02 12:45:00'),
(25, 10, 450.00, '2023-12-18 17:40:00'),
(26, 11, 330.00, '2022-03-21 13:55:00'),
(27, 12, 220.00, '2022-06-10 18:10:00'),
(28, 11, 280.00, '2022-08-28 14:20:00'),
(29, 12, 190.00, '2022-11-05 16:40:00'),
(30, 11, 310.00, '2023-02-14 19:00:00'),
(26, 12, 270.00, '2023-05-23 12:35:00'),
(27, 11, 350.00, '2023-08-19 14:50:00'),
(28, 12, 230.00, '2023-11-30 17:20:00'),
(29, 11, 310.00, '2024-01-08 19:45:00'),
(30, 12, 260.00, '2024-03-15 12:15:00'),
(31, 13, 400.00, '2022-02-28 13:10:00'),
(32, 14, 520.00, '2022-04-15 15:45:00'),
(33, 13, 390.00, '2022-07-09 17:35:00'),
(34, 14, 450.00, '2022-09-19 20:25:00'),
(35, 13, 470.00, '2022-12-30 14:50:00'),
(31, 14, 390.00, '2023-03-02 18:00:00'),
(32, 13, 420.00, '2023-06-12 20:40:00'),
(33, 14, 520.00, '2023-09-15 19:10:00'),
(34, 13, 450.00, '2023-12-04 12:55:00'),
(35, 14, 480.00, '2024-02-18 14:30:00'),
(36, 15, 550.00, '2022-03-14 13:25:00'),
(37, 16, 280.00, '2022-06-26 17:50:00'),
(38, 15, 600.00, '2022-08-22 19:20:00'),
(39, 16, 320.00, '2022-10-17 15:30:00'),
(40, 15, 430.00, '2022-12-09 13:45:00'),
(36, 16, 360.00, '2023-03-20 16:05:00'),
(37, 15, 580.00, '2023-06-24 18:30:00'),
(38, 16, 290.00, '2023-09-01 12:20:00'),
(39, 15, 460.00, '2023-11-08 14:45:00'),
(40, 16, 370.00, '2024-01-25 19:10:00'),
(41, 17, 480.00, '2022-05-01 12:15:00'),
(42, 18, 390.00, '2022-07-12 13:40:00'),
(43, 17, 570.00, '2022-09-05 16:55:00'),
(44, 18, 350.00, '2022-11-23 18:30:00'),
(45, 17, 430.00, '2023-02-05 20:20:00'),
(41, 18, 490.00, '2023-05-18 14:05:00'),
(42, 17, 510.00, '2023-08-10 19:50:00'),
(43, 18, 390.00, '2023-11-20 13:15:00'),
(44, 17, 430.00, '2024-01-12 16:25:00'),
(45, 18, 510.00, '2024-04-05 19:55:00'),
(46, 19, 310.00, '2022-01-19 14:45:00'),
(47, 20, 260.00, '2022-04-07 13:20:00'),
(48, 19, 370.00, '2022-06-11 16:35:00'),
(49, 20, 290.00, '2022-08-03 20:10:00'),
(50, 19, 410.00, '2022-11-14 13:30:00'),
(46, 20, 320.00, '2023-03-01 18:15:00'),
(47, 19, 430.00, '2023-06-09 12:25:00'),
(48, 20, 390.00, '2023-09-24 14:55:00'),
(49, 19, 470.00, '2023-12-10 20:45:00'),
(50, 20, 310.00, '2024-03-29 19:10:00');

INSERT INTO Orders (customer_id, restaurant_id, order_amount, order_date) VALUES
(1, 1, 2800, '2025-07-11 12:30:00'),
(2, 1, 3200, '2025-07-12 13:20:00'),
(3, 1, 2100, '2025-07-13 14:40:00'),
(4, 1, 2700, '2025-07-14 15:30:00'),
(5, 1, 2500, '2025-07-15 16:10:00'),
(1, 1, 3100, '2025-07-16 17:20:00'),
(2, 1, 2200, '2025-07-17 18:50:00'),
(3, 1, 2600, '2025-07-18 19:30:00'),
(4, 1, 2900, '2025-07-19 20:10:00'),
(5, 1, 3400, '2025-07-20 21:00:00'),
(1, 1, 2100, '2025-07-21 12:40:00'),
(2, 1, 2800, '2025-07-22 14:10:00'),
(3, 1, 2500, '2025-07-23 15:50:00'),
(4, 1, 2300, '2025-07-24 17:15:00'),
(5, 1, 2700, '2025-07-25 18:30:00'),
(1, 1, 3100, '2025-07-26 19:20:00'),
(2, 1, 3200, '2025-07-27 20:05:00'),
(3, 1, 2500, '2025-07-28 21:10:00'),
(4, 1, 2900, '2025-07-29 22:00:00'),
(5, 1, 3400, '2025-07-30 23:15:00'),
(6, 3, 2800, '2025-07-11 13:10:00'),
(7, 3, 2300, '2025-07-12 14:15:00'),
(8, 3, 3100, '2025-07-13 15:25:00'),
(9, 3, 2500, '2025-07-14 16:35:00'),
(10, 3, 2600, '2025-07-15 17:45:00'),
(6, 3, 3300, '2025-07-16 18:55:00'),
(7, 3, 2900, '2025-07-17 19:20:00'),
(8, 3, 2700, '2025-07-18 20:00:00'),
(9, 3, 2100, '2025-07-19 21:10:00'),
(10, 3, 3200, '2025-07-20 22:15:00'),
(6, 3, 2400, '2025-07-21 12:35:00'),
(7, 3, 3000, '2025-07-22 14:25:00'),
(8, 3, 2500, '2025-07-23 15:55:00'),
(9, 3, 2800, '2025-07-24 17:05:00'),
(10, 3, 3300, '2025-07-25 18:15:00'),
(6, 3, 2100, '2025-07-26 19:30:00'),
(7, 3, 2600, '2025-07-27 20:45:00'),
(8, 3, 3100, '2025-07-28 21:55:00'),
(9, 3, 2500, '2025-07-29 22:40:00'),
(10, 3, 2700, '2025-07-30 23:20:00'),
(16, 7, 3200, '2025-07-11 13:25:00'),
(17, 7, 2900, '2025-07-12 14:35:00'),
(18, 7, 2500, '2025-07-13 15:45:00'),
(19, 7, 2100, '2025-07-14 16:55:00'),
(20, 7, 2700, '2025-07-15 18:05:00'),
(16, 7, 3300, '2025-07-16 19:15:00'),
(17, 7, 3100, '2025-07-17 20:25:00'),
(18, 7, 2600, '2025-07-18 21:35:00'),
(19, 7, 2300, '2025-07-19 22:45:00'),
(20, 7, 2800, '2025-07-20 23:55:00'),
(16, 7, 3000, '2025-07-21 12:05:00'),
(17, 7, 2500, '2025-07-22 13:15:00'),
(18, 7, 3100, '2025-07-23 14:25:00'),
(19, 7, 2700, '2025-07-24 15:35:00'),
(20, 7, 3300, '2025-07-25 16:45:00'),
(16, 7, 2200, '2025-07-26 17:55:00'),
(17, 7, 2600, '2025-07-27 19:05:00'),
(18, 7, 3100, '2025-07-28 20:15:00'),
(19, 7, 2700, '2025-07-29 21:25:00'),
(20, 7, 2900, '2025-07-30 22:35:00'),
(31, 13, 2700, '2025-07-11 13:45:00'),
(32, 13, 2300, '2025-07-12 15:05:00'),
(33, 13, 3100, '2025-07-13 16:15:00'),
(34, 13, 2900, '2025-07-14 17:25:00'),
(35, 13, 2500, '2025-07-15 18:35:00'),
(31, 13, 2800, '2025-07-16 19:45:00'),
(32, 13, 3300, '2025-07-17 20:55:00'),
(33, 13, 2700, '2025-07-18 22:05:00'),
(34, 13, 3100, '2025-07-19 23:15:00'),
(35, 13, 2900, '2025-07-20 12:25:00'),
(31, 13, 2600, '2025-07-21 13:35:00'),
(32, 13, 3100, '2025-07-22 14:45:00'),
(33, 13, 2500, '2025-07-23 15:55:00'),
(34, 13, 2800, '2025-07-24 17:05:00'),
(35, 13, 3000, '2025-07-25 18:15:00'),
(31, 13, 3300, '2025-07-26 19:25:00'),
(32, 13, 2500, '2025-07-27 20:35:00'),
(33, 13, 3100, '2025-07-28 21:45:00'),
(34, 13, 2700, '2025-07-29 22:55:00'),
(35, 13, 2900, '2025-07-30 23:55:00'),
(41, 17, 2500, '2025-07-11 13:50:00'),
(42, 17, 3000, '2025-07-12 15:10:00'),
(43, 17, 2700, '2025-07-13 16:20:00'),
(44, 17, 2900, '2025-07-14 17:30:00'),
(45, 17, 2500, '2025-07-15 18:40:00'),
(41, 17, 3200, '2025-07-16 19:50:00'),
(42, 17, 2700, '2025-07-17 21:00:00'),
(43, 17, 3100, '2025-07-18 22:10:00'),
(44, 17, 2800, '2025-07-19 23:20:00'),
(45, 17, 2600, '2025-07-20 12:30:00'),
(41, 17, 3100, '2025-07-21 13:40:00'),
(42, 17, 2500, '2025-07-22 14:50:00'),
(43, 17, 3000, '2025-07-23 16:00:00'),
(44, 17, 2900, '2025-07-24 17:10:00'),
(45, 17, 3300, '2025-07-25 18:20:00'),
(41, 17, 2700, '2025-07-26 19:30:00'),
(42, 17, 3100, '2025-07-27 20:40:00'),
(43, 17, 2500, '2025-07-28 21:50:00'),
(44, 17, 2800, '2025-07-29 23:00:00'),
(45, 17, 3000, '2025-07-30 23:55:00');




-- Assignment Problems
-- 🔸 . Aggregate Functions
-- COUNT(), SUM(), AVG(), MIN(), MAX()
-- 1.      Find the total number of orders placed on the platform.

SELECT COUNT(*) FROM Orders;

-- 2.      What is the average order value across all orders?

SELECT AVG(order_amount) FROM Orders;

-- 3.      Find the highest and lowest order values recorded.

SELECT MAX(order_amount), MIN(order_amount) FROM Orders;

-- 4.      Get the total revenue generated by each restaurant.

SELECT O.restaurant_id, R.restaurant_name,SUM(O.order_amount) FROM Orders O JOIN Restaurants R ON O.restaurant_id = R.restaurant_id GROUP BY restaurant_id ;

-- 5.      Count how many orders have been placed by each customer.
SELECT O.customer_id, C.customer_name, COUNT(O.customer_id) FROM Orders O JOIN Customers C ON O.customer_id = C.customer_id GROUP BY customer_id;
-- NULL Handling in Aggregates
-- 6.      Modify your AVG calculation to exclude NULL values in order_amount (if any exist).

INSERT INTO Orders (customer_id, restaurant_id, order_amount, order_date) VALUES
(1, 1, NULL, '2025-07-01 12:30:00'),
(2, 2, NULL, '2025-07-02 14:15:00'),
(6, 3, NULL, '2025-07-03 16:45:00'),
(12, 5, NULL, '2025-07-04 18:00:00'),
(17, 7, NULL, '2025-07-05 13:20:00'),
(22, 9, NULL, '2025-07-06 19:10:00'),
(28, 11, NULL, '2025-07-07 15:55:00'),
(33, 13, NULL, '2025-07-08 17:40:00'),
(38, 15, NULL, '2025-07-09 20:05:00'),
(43, 17, NULL, '2025-07-10 14:30:00');

SELECT AVG(order_amount) FROM Orders;
SELECT AVG(order_amount) FROM Orders WHERE order_amount IS NOT NULL;

-- 7.      If order_amount is sometimes missing, show how COUNT(order_amount) differs from COUNT(*).

SELECT COUNT(*), COUNT(order_amount) FROM Orders;

-- Combining Aggregates with WHERE and GROUP BY
-- 8.      Get the total revenue for each city (based on restaurant city) where total revenue is greater than ₹50,000.

SELECT R.restaurant_city, SUM(order_amount) total_revenue 
FROM Restaurants R INNER JOIN Orders O ON R.restaurant_id = O.restaurant_id GROUP BY restaurant_city HAVING SUM(order_amount)>50000 ORDER BY SUM(order_amount) ASC;

-- 9.      Calculate the average order value per cuisine type.

SELECT R.cuisine_type, AVG(order_amount) total_revenue
 FROM Restaurants R INNER JOIN Orders O ON R.restaurant_id = O.restaurant_id GROUP BY cuisine_type ORDER BY AVG(order_amount) ASC;

-- 10.  Show the number of orders and average order amount for each restaurant.

SELECT * FROM Restaurants R JOIN Orders O ON R.restaurant_id = O.restaurant_id;
SELECT R.restaurant_id ,AVG(order_amount) AVG_Order_Amount, COUNT(order_id) number_of_orders 
FROM Restaurants R INNER JOIN Orders O ON R.restaurant_id = O.restaurant_id GROUP BY R.restaurant_id ORDER BY number_of_orders;

-- 🔸 . GROUP BY and HAVING
-- Purpose of GROUP BY
-- 11.  Group all orders by restaurant_id and calculate the total orders and total revenue for each.

SELECT R.restaurant_id , SUM(order_amount) total_revenue, COUNT(order_id) number_of_orders 
FROM Restaurants R INNER JOIN Orders O ON R.restaurant_id = O.restaurant_id GROUP BY R.restaurant_id ORDER BY SUM(order_amount) ASC; 

-- 12.  Find the number of distinct customers ordering from each cuisine type.

SELECT * FROM Orders O JOIN Restaurants R On O.restaurant_id = R.restaurant_id;
SELECT COUNT(O.customer_id) number_of_distinct_customers, R.cuisine_type 
FROM Orders O INNER JOIN Restaurants R On O.restaurant_id = R.restaurant_id GROUP BY R.cuisine_type ORDER BY number_of_distinct_customers ASC;

-- Grouping by Multiple Columns
-- 13.  Group orders by both city and cuisine_type and calculate total revenue.

SELECT * FROM Orders O JOIN Restaurants R On O.restaurant_id = R.restaurant_id;
SELECT R.cuisine_type,  R.restaurant_city, SUM(order_amount) 
FROM Orders O INNER JOIN Restaurants R On O.restaurant_id = R.restaurant_id GROUP BY  R.cuisine_type, R.restaurant_city ORDER BY  R.restaurant_city, SUM(order_amount) ASC;

-- 14.  Group by customer_id and restaurant_id to find how often each customer ordered from each restaurant.

SELECT customer_id, restaurant_id, COUNT(order_id) ordered_from_each_restaurant FROM Orders GROUP BY customer_id, restaurant_id ORDER BY customer_id ASC;

-- Filtering Grouped Results using HAVING
-- 15.  Find restaurants that have received more than 100 orders.

SELECT restaurant_id, COUNT(Order_id) Total_orders_Of_Each_Restaurant FROM Orders GROUP BY restaurant_id HAVING Total_orders_Of_Each_Restaurant>=100 ORDER BY Total_orders_Of_Each_Restaurant ASC;

-- 16.  List customers who have placed more than 5 orders and have spent over ₹5,000 in total.
SELECT O.customer_id, C.customer_name, SUM(order_amount), COUNT(order_id) 
FROM Orders O INNER JOIN Customers C ON O.customer_id = C.customer_id GROUP BY customer_id HAVING SUM(order_amount) > 5000 AND COUNT(order_id) >5 ORDER BY SUM(order_amount) ASC;

-- Difference between WHERE and HAVING
-- 17.  Use WHERE to filter orders placed in the year 2024, then use GROUP BY to find total orders per city.

SELECT * FROM Orders O JOIN Restaurants R ON O.restaurant_id = R.restaurant_id WHERE order_date BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59';
SELECT R.restaurant_city, Count(order_id) total_orders_per_city 
FROM Orders O INNER JOIN Restaurants R ON O.restaurant_id = R.restaurant_id WHERE order_date BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59' GROUP BY restaurant_city ORDER BY total_orders_per_city ASC;

-- 18.  Write a query to group orders by restaurant, filter total revenue greater than ₹30,000 using HAVING.

SELECT * FROM Orders;
SELECT restaurant_id, SUM(order_amount) total_revenue FROM Orders GROUP By restaurant_id HAVING total_revenue > 30000 ORDER BY total_revenue ASC;








