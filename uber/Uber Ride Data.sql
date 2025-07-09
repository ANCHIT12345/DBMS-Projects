USE Uber_database;

-- Assignment Questions by Topic
-- 🔸 2. Aggregate Functions
-- 📌 COUNT(), SUM(), AVG(), MIN(), MAX()
-- 1.      Find the total number of trips completed on the platform.

SELECT COUNT(*) FROM Trips;

-- 2.      What is the total fare collected from all trips?

SELECT SUM(fare_amount) FROM Trips;

-- 3.      What is the average fare amount per trip across all data?

SELECT AVG(fare_amount) FROM Trips;

-- 4.      Show the minimum and maximum fare ever charged in a trip.

SELECT MIN(fare_amount), MAX(fare_amount) FROM Trips;

-- 5.      What is the total distance covered by all drivers?

SELECT SUM(distance_km) FROM Trips;

-- 📌 NULL Handling in Aggregates
-- 6.      Calculate the average fare, excluding trips where fare is NULL (free rides or test data).

INSERT INTO Trips (driver_id,rider_id,trip_date,distance_km,fare_amount)
VALUES(1,1,'2023-02-07 20:51:01',20.10, NULL),
(5,3,'2023-02-07 20:51:01',20.10, NULL),
(20,31,'2023-02-07 20:51:01',20.10, NULL),
(61,41,'2023-02-07 20:51:01',20.10, NULL);

SELECT AVG(fare_amount) without_null FROM Trips WHERE fare_amount IS NOT NULL; 
SELECT AVG(fare_amount) with_null FROM Trips ;

-- 7.      Show the difference between COUNT(*) and COUNT(fare_amount) when NULLs exist in fare_amount.

SELECT COUNT(fare_amount) Fare_count , COUNT(*) Full_Count FROM Trips;

-- 📌 Combining Aggregates with WHERE and GROUP BY
-- 8.      Calculate the total fare collected per city (join with Cities table).

SELECT SUM(fare_amount) Total_fare_per_city, C.city_name
FROM Trips T INNER JOIN Riders R ON T.rider_id = R.rider_id INNER JOIN Cities C ON R.city_id = C.city_id GROUP BY C.city_name ORDER BY Total_fare_per_city ASC;

-- 9.      Show average trip fare and number of trips for each driver who joined before 2024.

SELECT  D.driver_name, COUNT(*) number_of_trips, AVG(fare_amount) average_trip_fare 
FROM Trips T INNER JOIN Drivers D ON T.driver_id = D.driver_id GROUP BY D.driver_name ORDER BY number_of_trips ASC;

-- 10.  Display the total revenue and average distance per trip for each city, but only include cities from the state 'Maharashtra'.

SELECT C.city_name, SUM(fare_amount) total_revenue,AVG(distance_km) average_distance
FROM Trips T INNER JOIN Riders R ON T.rider_id = R.rider_id INNER JOIN Cities C ON R.city_id = C.city_id 
WHERE C.state = 'Maharashtra' GROUP BY C.city_name ORDER BY average_distance ASC;

-- 🔸 3. GROUP BY and HAVING
-- 📌 Purpose of GROUP BY
-- 11.  Show how many trips were made by each driver.

SELECT  D.driver_name, COUNT(*) Trips_made, SUM(T.*)
FROM Trips T INNER JOIN Drivers D ON T.driver_id = D.driver_id GROUP BY D.driver_name ORDER BY Trips_made ASC;

-- 12.  Calculate the total fare collected by each rider.

SELECT R.name, SUM(fare_amount) total_fare_collected
FROM Trips T INNER JOIN Riders R ON T.rider_id = R.rider_id GROUP BY R.name ORDER BY total_fare_collected ASC;

-- 📌 Grouping by Multiple Columns
-- 13.  Group trips by city_name and state, and display the total fare and total trips per city-state pair.

SELECT C.state, C.city_name, SUM(fare_amount) total_revenu_per_city_state, COUNT(*) total_trips_per_city_state
FROM Trips T INNER JOIN Riders R ON T.rider_id = R.rider_id INNER JOIN Cities C ON R.city_id = C.city_id 
GROUP BY C.state, C.city_name ORDER BY total_trips_per_city_state ASC;

-- 14.  Group trips by both driver_id and trip_date, and show how many trips each driver did per day.

INSERT INTO Trips (driver_id,rider_id,trip_date,distance_km,fare_amount)
VALUES (128,4,'2022-01-01 09:15:30.000', 28.99,599);

SELECT driver_id, DATE(trip_date), COUNT(*) FROM Trips GROUP BY  DATE(trip_date), driver_id;

SELECT driver_id, CAST(trip_date AS DATE) trip_date, COUNT(*) Total_rides FROM Trips GROUP BY  CAST(trip_date AS DATE),driver_id ORDER BY Total_rides DESC;

-- 📌 Filtering grouped results using HAVING
-- 15.  Find drivers who have completed more than 100 trips. (making it more than equal to 15)

SELECT D.driver_name, COUNT(*) Total_trips FROM Trips T INNER JOIN Drivers D ON T.driver_id = D.driver_id GROUP BY D.driver_name HAVING COUNT(*) >= 15;


-- 16.  List riders who have spent more than ₹10,000 in total fare.(making it more than equal to 2500)

SELECT R.name ,SUM(fare_amount) Total_fare FROM Trips T INNER JOIN Riders R ON T.rider_id = R.rider_id GROUP BY R.name HAVING SUM(fare_amount) >= 2500;

-- 📌 Difference between WHERE and HAVING
-- 17.  Use WHERE to filter trips that occurred in 2024, then group by city and show average fare per trip.

SELECT C.city_name, AVG(fare_amount) average_fare_per_trip
FROM Trips T INNER JOIN Riders R ON T.rider_id = R.rider_id INNER JOIN Cities C ON R.city_id = C.city_id
WHERE YEAR(trip_date) = 2024 
GROUP BY C.city_name
ORDER BY average_fare_per_trip ASC;

-- 18.  Group trips by driver and use HAVING to show only drivers who made more than ₹50,000 in fare. (making it more than equal to 3500)

SELECT D.driver_name, SUM(fare_amount) Total_Earned 
FROM Trips T INNER JOIN Drivers D ON T.driver_id = D.driver_id GROUP BY D.driver_name HAVING SUM(fare_amount) >= 3500;




