USE E_commerce_Databases;

--Assignment: SQL Joins in an E-Commerce Database
--You are working with a database of an E-Commerce application that contains the following tables:
--Tables:

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM Order_Items;
SELECT * FROM Suppliers;

DROP TABLE Order_Items;
DROP TABLE Suppliers;
DROP TABLE Products;
DROP TABLE Orders;
DROP TABLE Customers;



--Assignment Tasks by Join Type
--🔹 INNER JOIN
--Q1. Retrieve a list of all orders along with the customer name who placed them.

SELECT O.order_id,C.name FROM Orders O INNER JOIN Customers C ON O.customer_id = C.customer_id;

--Q2. List all products along with their quantities and order dates (using Order_Items, Orders, Products).

SELECT P.product_id, P.name, OI.quantity, O.order_date
FROM Order_Items OI INNER JOIN Products P ON OI.product_id = P.product_id INNER JOIN Orders O ON OI.order_id = O.order_id ORDER BY product_id ASC;

--🔹 LEFT JOIN
--Q3. List all customers and their orders, if any. Show customers even if they haven’t placed any order.

SELECT * FROM Customers C LEFT JOIN Orders O ON C.customer_id = O.customer_id WHERE O.order_id IS NULL ORDER BY C.customer_id ASC;

--Q4. Get a list of all products along with their supplier names. Include products even if no supplier is assigned.

SELECT P.product_id, S.supplier_id FROM Products P LEFT JOIN Suppliers S ON P.product_id = S.product_id;

--🔹  RIGHT JOIN
--Q5. List all suppliers and the products they supply. Include suppliers who haven't supplied any product yet.

SELECT * FROM Products P RIGHT JOIN Suppliers S ON P.product_id = S.product_id ORDER BY S.supplier_id ASC;

--🔹  FULL OUTER JOIN
--Q6. Get a combined list of customers and orders — include all customers and all orders even if no match exists.
--(Note: If FULL OUTER JOIN is not supported by your DBMS, use UNION of LEFT and RIGHT joins)

SELECT * FROM Orders O FULL JOIN Customers C ON O.order_id = C.customer_id;

--🔹 CROSS JOIN
--Q7. Generate a list of all possible combinations of customers and products (e.g., for promotional offers).

SELECT * FROM Customers CROSS JOIN Products;

--Q8. Count how many combinations were generated in the above query

SELECT COUNT(*) FROM Customers CROSS JOIN Products;

--🔹 Aliasing Tables in Joins
--Q9. Rewrite Q4 using table aliases (e.g., c for Customers, o for Orders).

SELECT P.product_id, S.supplier_id FROM Products P LEFT JOIN Suppliers S ON P.product_id = S.product_id;

--Q10. Join Orders and Order_Items using aliases and retrieve order ID and product quantity.

SELECT O.order_id, OI.quantity FROM Orders O INNER JOIN Order_Items OI ON O.order_id = OI.order_id;

--🔹 Joining More Than Two Tables
--Q11. List each customer’s name, order ID, product name, and quantity for all purchases.

SELECT C.name, O.order_id, P.name, OI.quantity 
FROM Order_Items OI 
INNER JOIN Orders O ON O.order_id = OI.order_id 
INNER JOIN Products P ON OI.product_id = P.product_id 
INNER JOIN Customers C ON O.customer_id = C.customer_id
ORDER BY OI.quantity ASC;

--Q12. Show the supplier name, product name, order ID, and quantity for each order.

SELECT S.name, P.name, OI.order_id , OI.quantity
FROM Suppliers S
INNER JOIN Products P ON S.product_id = P.product_id
INNER JOIN Order_Items OI ON P.product_id = OI.product_id
ORDER BY S.supplier_id ASC;


--🔹  RIGHT JOIN
--Q5. List all suppliers and the products they supply. Include suppliers who haven't supplied any product yet.

--SELECT * FROM Products P RIGHT JOIN Suppliers S ON P.product_id = S.product_id ORDER BY S.supplier_id ASC;







