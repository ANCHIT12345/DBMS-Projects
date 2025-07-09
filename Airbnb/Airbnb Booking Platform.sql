USE Airbnb_Booking_Platform;
--SQL Assignment: Subqueries in Airbnb Booking Platform

--Context:

--Assignment Problems by Subquery Type

--🔹 1. Scalar Subqueries (returning single value)

--Show the title and price of the listing with the highest price per night.

SELECT * FROM Listings WHERE price_per_night = (SELECT MAX(price_per_night) FROM Listings);

--Find the average price per night of all listings. Then display listings with a price greater than the average.

SELECT AVG(price_per_night) FROM Listings;

SELECT * FROM Listings L WHERE price_per_night > (SELECT AVG(price_per_night) FROM Listings);

--Display the name of the host with the highest rating.

SELECT * FROM Hosts WHERE rating = (SELECT MAX(rating) FROM Hosts);

--🔹 2. Table Subqueries (IN, EXISTS, NOT IN)

--List all guests who have made at least one booking (use EXISTS).

SELECT * FROM Guests WHERE Exists (SELECT guest_id FROM Bookings);

--List all listings that have never been booked (use NOT IN or NOT EXISTS).

SELECT * FROM Listings WHERE NOT EXISTS (SELECT Listing_id FROM Bookings);

--Find hosts who own more than one listing (using IN with a subquery).

SELECT * FROM Hosts WHERE (SELECT Count(*) FROM Listings)>1;

--🔹 3. Subqueries in SELECT, WHERE, and FROM Clauses

--Display each listing with its average rating (use subquery in SELECT).

SELECT L.*, ISNULL((SELECT AVG(rating) FROM Reviews R WHERE R.listing_id = L.listing_id), 0) AS AVG_Rating FROM Listings L;

--List all bookings where the total_amount is above the average total amount across all bookings (subquery in WHERE).

SELECT * FROM Bookings WHERE total_amount > (SELECT AVG(total_amount) FROM Bookings);

--Show a summary table (listing_id, total_bookings, total_earned) by using a subquery in the FROM clause.

SELECT * FROM Bookings;

SELECT B.listing_id, B.total_bookings, B.total_earned FROM 
(SELECT listing_id, COUNT(*) total_bookings, SUM(total_amount) total_earned FROM Bookings GROUP BY listing_id) B;

--🔹 4. Nested Subqueries

--Find the top 3 listings by total booking amount, then show the title, host name, and total earnings of those listings.

SELECT * FROM listings L 
JOIN Hosts H ON L.host_id = H.host_id 
JOIN (SELECT TOP 3 listing_id, SUM(total_amount) AS total_earned FROM Bookings GROUP BY listing_id ORDER BY total_earned DESC) AS S ON L.listing_id = S.listing_id;

--List guests who reviewed listings that have more than 10 total reviews, and those reviews had a rating of 5.

SELECT G.guest_id, G.name
FROM Guests G JOIN Reviews R ON G.guest_id = R.guest_id 
WHERE rating = 5 
AND R.listing_id IN(SELECT R2.listing_id FROM (SELECT listing_id, COUNT(*) total_reviews FROM Reviews GROUP BY listing_id) R2 WHERE R2.total_reviews >1);

SELECT COUNT(*) total_reviews, listing_id FROM Reviews WHERE rating = 5 GROUP BY listing_id HAVING COUNT(*) > 1

--🔹 5. Correlated Subqueries vs Independent Subqueries

--Show all listings where the price per night is higher than the average price per night in the same city (correlated subquery).

SELECT * FROM Listings L WHERE L.price_per_night > (SELECT AVG(L2.price_per_night) FROM Listings L2 WHERE L2.city = L.city);

--For each host, list the host's name and number of listings (use correlated subquery).

SELECT H.name, (SELECT COUNT(*) FROM Listings L WHERE L.host_id = H.host_id) number_of_listings FROM Hosts H

--List guests who only booked properties hosted by the same host more than once (complex correlation).

SELECT name  FROM Guests G 
WHERE Exists(
SELECT 1 FROM Hosts H WHERE (
SELECT COUNT(*) FROM Bookings B JOIN Listings L ON B.listing_id = L.listing_id WHERE B.guest_id = G.guest_id AND L.host_id = H.host_id) >1)

SELECT 1 FROM Hosts H WHERE (SELECT COUNT(*) FROM Bookings B JOIN Listings L ON B.listing_id = L.listing_id WHERE L.host_id = H.host_id) >1