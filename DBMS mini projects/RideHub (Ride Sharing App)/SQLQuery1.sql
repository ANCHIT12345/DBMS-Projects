--Mini Project Assignment – RideHub (Ride Sharing App)

CREATE DATABASE RideHub;
USE RideHub;

--1. Project Description
--RideHub is a simplified ride-sharing platform like Uber or Ola. The goal of this project is to
--help learners practice real-world SQL queries by analyzing user activity, driver
--performance, ride behavior, payments, and feedback data. This project covers intermediate
--SQL concepts including joins, subqueries, aggregate functions, window functions, and case
--expressions.
--2. Table Details
--Users Table
--UserID (PK), UserName, City, JoinDate

CREATE TABLE Users
(
UserID INT PRIMARY KEY IDENTITY(1,1),
UserName VARCHAR(100),
City VARCHAR(100),
JoinDate DATE
);


--Drivers Table
--DriverID (PK), DriverName, City, JoinDate, Rating

CREATE TABLE Drivers 
(
DriverID INT PRIMARY KEY IDENTITY(1,1),
DriverName VARCHAR(100),
City VARCHAR(100),
JoinDate DATE,
Rating DECIMAL(10,2)
);

--Rides Table
--RideID (PK), UserID (FK), DriverID (FK), StartCity, EndCity, Fare, RideDate, Status

CREATE TABLE Rides
(
RideID INT PRIMARY KEY IDENTITY(1,1),
UserID INT REFERENCES Users(UserID),
DriverID INT REFERENCES Drivers(DriverID),
StartCity VARCHAR(100),
EndCity VARCHAR(100),
Fare DECIMAL(10,2),
RideDate DATETIME,
Status VARCHAR(50)
);

--Payments Table
--PaymentID (PK), RideID (FK), Amount, PaymentMethod, PaymentStatus

CREATE TABLE Payments
(
PaymentID INT PRIMARY KEY IDENTITY(1,1),
RideID INT REFERENCES Rides(RideID),
Amount DECIMAL(10,2),
PaymentMethod VARCHAR(50),
PaymentStatus VARCHAR(50)
);

--Feedback Table
--FeedbackID (PK), RideID (FK), UserRating, DriverRating, Comments

CREATE TABLE Feedback
(
FeedbackID INT PRIMARY KEY IDENTITY(1,1),
RideID INT REFERENCES Rides(RideID),
UserRating DECIMAL(10,2),
DriverRating DECIMAL(10,2),
Comments VARCHAR(500)
);

--3. Part1
--User Management &amp; Behavior
-- - List all users who joined in the last 6 months and have completed at least one ride.

SELECT * FROM Users;

SELECT * FROM Users WHERE DATEDIFF(MONTH,JoinDate,GETDATE()) < 7 AND UserID IN (SELECT UserID FROM Rides);
INSERT INTO Users (UserName, City, JoinDate) VALUES ('Bob', 'Bangalore', '2025-06-01');
INSERT INTO Rides (UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status)  VALUES (4, 1, 'Bangalore', 'Mysore', 600, '2025-06-06', 'Completed');

-- - Find users who have not taken any rides yet.

SELECT * FROM Users WHERE UserID NOT IN (SELECT UserID FROM Rides);

-- - Display the top 3 cities with the highest number of active users.

SELECT * FROM Rides;
SELECT TOP 3 StartCity, COUNT(RideID) FROM Rides GROUP BY StartCity ORDER BY COUNT(RideID) DESC;


-- - Show each user along with the number of rides they’ve taken and the total fare paid.

SELECT * FROM Users;
SELECT * FROM Rides;

SELECT U.UserID, U.UserName, COUNT(RideID), ISNULL(SUM(Fare),0) Total_Fare_paid FROM Users U LEFT JOIN Rides R ON U.UserID = R.userID GROUP BY U.UserID,U.UserName;

INSERT INTO Users (UserName, City, JoinDate) VALUES ('userxyz', 'Bangalore', '2021-11-21');
INSERT INTO Users (UserName, City, JoinDate) VALUES ('userxyz1', 'Chennai', '2022-12-25');
INSERT INTO Users (UserName, City, JoinDate) VALUES ('userxyz2', 'Mumbai', '2024-05-14');

-- - Categorize users into tiers like New, Regular, and Loyal based on ride history.(New:0-2,Regular:3-5,Loyal:6-8)

SELECT * FROM Rides;

WITH CTECOUNTRIDE AS(SELECT UserID, COUNT(RideID) AS TotalRides FROM Rides GROUP BY UserID)
SELECT UserID,
CASE
	WHEN TotalRides between 3 and 5 THEN 'Regular'
	WHEN TotalRides between 6 and 8 THEN 'Loyal'
	ELSE 'New'
END AS Badge
FROM CTECOUNTRIDE;

--Ride Lifecycle &amp; Operations
-- - List all rides with user name, driver name, origin, destination, fare, and ride status.

SELECT * FROM Users;
SELECT * FROM Drivers;
SELECT * FROM Rides;

SELECT UserName, DriverName, StartCity, EndCity, Fare, Status FROM Rides R INNER JOIN Users U ON R.UserID = U.UserID INNER JOIN Drivers D ON R.DriverID = D.DriverID;

-- - Show rides that were cancelled by users or drivers in the last 30 days.

SELECT * FROM Rides WHERE DATEDIFF(DAY, RideDate,GETDATE()) < 30 AND Status = 'Cancelled'

INSERT INTO Rides (UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status)  VALUES (4, 1, 'Bangalore', 'Mysore', 1600, '2025-07-04', 'Cancelled');

-- - Identify rides with a fare above the average fare in their respective city.

SELECT AVG(Fare) FROM Rides GROUP BY startCity;

SELECT * FROM Rides; 

SELECT * FROM Rides WHERE Fare > (SELECT AVG(Fare) FROM Rides);

SELECT * FROM Rides R 
WHERE R.fare > (SELECT AVG(Fare) FROM Rides R1 WHERE R1.StartCity = R.StartCity GROUP BY StartCity)

-- - Display the 5 most expensive rides taken from each city.
SELECT * FROM Rides; 

SELECT StartCity, Fare, DENSE_RANK() OVER(PARTITION BY StartCity ORDER BY Fare) AS rn FROM Rides

WITH CTE_RN AS
(SELECT StartCity, Fare, DENSE_RANK() OVER(PARTITION BY StartCity ORDER BY Fare) AS rn FROM Rides)
SELECT StartCity, Fare FROM CTE_RN WHERE rn >=2

-- - For each user, list their last 3 rides along with fare and driver name.

SELECT * FROM Rides;

SELECT RideID, UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status, DENSE_RANK() OVER(PARTITION BY UserID Order BY RideDate DESC) FROM Rides

SELECT * FROM Rides;
WITH CTE_RideData AS
(SELECT RideID, UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status, DENSE_RANK() OVER(PARTITION BY UserID Order BY RideDate DESC) as rn FROM Rides)
SELECT RideID, UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status FROM CTE_RideData WHERE rn <=1;

--4. Part2
--Driver Engagement &amp; Performance
-- - List drivers who haven’t completed any rides in the past 60 days.

SELECT * FROM Drivers
SELECT DriverID FROM Rides WHERE DATEDIFF(DAY, RideDate, GETDATE()) < 60
SELECT * FROM Drivers WHERE DriverID NOT IN (SELECT DriverID FROM Rides WHERE DATEDIFF(DAY, RideDate, GETDATE()) < 60);

-- - Show total earnings for each driver along with their average ride fare.

SELECT DriverID, SUM(Fare) total_earnings, AVG(Fare) Avg_ride_fare FROM Rides GROUP BY DriverID

-- - Rank drivers based on total completed rides and show their overall rating.

SELECT * FROM Feedback
SELECT * FROM Rides

SELECT DriverID,COUNT(RideID) FROM Rides GROUP BY DriverID

SELECT DriverID, COUNT(R.RideID) Total_completed_rides, AVG(DriverRating) Overall_rating, ROW_NUMBER() OVER(ORDER BY COUNT(R.RideID) DESC) AS Driver_rank
FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID GROUP BY DriverID;

-- - Identify drivers with a lower-than-average rating among all active drivers.

--SELECT * FROM Rides;
--SELECT AVG(DriverRating) FROM Feedback;
--SELECT DriverID, AVG(DriverRating) FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID GROUP BY DriverID;

--SELECT * FROM Rides R1
--WHERE (SELECT AVG(DriverRating) 
--		FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID 
--		WHERE R.RideID = R1.RideID GROUP BY DriverID) < (SELECT AVG(DriverRating) FROM Feedback);

SELECT * 
FROM Drivers 
WHERE DriverID IN (
	SELECT DriverID
		FROM Rides R1
		WHERE (
		SELECT AVG(DriverRating) 
		FROM Rides R 
		INNER JOIN Feedback F ON R.RideID = F.RideID 
		WHERE R.RideID = R1.RideID GROUP BY DriverID
		) < (
		SELECT AVG(DriverRating) FROM Feedback
		)
);

-- - For each driver, show a classification like Top Performer, Average, or Needs Improvement based on total earnings and ride volume.

SELECT DriverID,COUNT(*),SUM(Fare) FROM Rides GROUP BY DriverID;

WITH cte_total_rides_total_earnings AS
(
SELECT DriverID, COUNT(*) total_rides, SUM(Fare) total_earnings FROM Rides GROUP BY DriverID
)
SELECT 
DriverID, total_rides, total_earnings,
CASE
	WHEN total_rides between 3 and 4  THEN 'Top Performer'
	WHEN total_rides between 1 and 2  THEN 'Average'
	ELSE  'Needs Improvement'
END AS [classification of rides],
CASE
	WHEN total_earnings > 2000 THEN 'Top Performer'
	WHEN total_earnings > 1000 THEN 'Average'
	ELSE  'Needs Improvement'
END AS [classification of total earnings]
FROM cte_total_rides_total_earnings;

--Payment Analytics
-- - List all rides that were paid in cash, credit card, or UPI, and their total value by payment mode.

SELECT  PaymentMethod ,COUNT(*) total_rides, SUM(Amount) total_value FROM Payments GROUP BY PaymentMethod

-- - Show all unsuccessful payments and the ride details they are associated with.

SELECT * FROM Rides R INNER JOIN Payments P ON R.RideID = P.RideID WHERE PaymentStatus = 'Failed' 

-- - Identify users whose total payments exceed the average total payments of all users.

SELECT AVG(Fare) FROM Rides
SELECT SUM(Fare) FROM Rides GROUP BY UserID

SELECT * FROM Users 
WHERE UserID IN
(SELECT UserID FROM Rides R WHERE (SELECT SUM(Fare) FROM Rides R1 WHERE R.RideID = R1.RideID GROUP BY UserID) > (SELECT AVG(Fare) FROM Rides))

-- - For each city, calculate the total revenue generated.

SELECT StartCity, SUM(Fare) FROM Rides GROUP BY StartCity;

-- - Display the number of rides per payment method per city.

SELECT StartCity ,PaymentMethod, COUNT(*) total_rides FROM Rides R INNER JOIN Payments P ON R.RideID = P.RideID GROUP BY P.PaymentMethod, StartCity;

--Feedback &amp; Quality Insights
-- - List all rides where driver rating is below 3.0 or user rating is below 2.5.

SELECT * FROM Rides WHERE RideID IN (SELECT RideID FROM Feedback WHERE DriverRating > 3.0 OR UserRating > 2.5);

-- - Identify users who frequently rate their drivers below  4.

SELECT * FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID WHERE DriverRating < 4.00

SELECT COUNT(*) AS tn FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID WHERE DriverRating < 4.00 GROUP BY R.userID

WITH CTE_TN AS
(
SELECT UserID, COUNT(*) AS tn FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID WHERE DriverRating < 4.00 GROUP BY R.userID
)
SELECT * FROM CTE_TN cte INNER JOIN Users U ON cte.UserID = U.UserID WHERE tn >= 1;

-- - Show drivers who have received more than 5 feedback comments.

SELECT * FROM Feedback 
SELECT * FROM Rides
SELECT DriverID, COUNT(FeedbackID) FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID GROUP BY DriverID;

WITH Cte_feedback_count AS 
(
SELECT DriverID, COUNT(FeedbackID) feedbackcount FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID GROUP BY DriverID
)
SELECT * FROM Cte_feedback_count cfc INNER JOIN Drivers D ON cfc.DriverID = D.DriverID WHERE feedbackcount > 1;

-- - For each ride, show a comment (if available) and classify user experience as Positive, Neutral, or Negative based on rating values.

WITH CTE_experience AS
(
SELECT Comments, DriverRating FROM Feedback
)
SELECT Comments, DriverRating,
CASE 
	WHEN DriverRating between 3.5 and 5 THEN 'Positive'
	WHEN DriverRating between 2 and 3.5 THEN 'Neutral'
	ELSE 'Negative'
END AS experience
FROM CTE_experience

-- - Find the top 3 most appreciated drivers based on user feedback in each city.

SELECT R.*,F.*, ROW_NUMBER() OVER(PARTITION BY StartCity ORDER BY F.DriverRating DESC) 
FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID;

WITH cte_top AS
(SELECT R.RideID, R.DriverID, ROW_NUMBER() OVER(PARTITION BY StartCity ORDER BY F.DriverRating DESC) AS rn
FROM Rides R INNER JOIN Feedback F ON R.RideID = F.RideID)
SELECT * FROM cte_top WHERE rn <=3;


--5. Insert Statements for Sample Data
INSERT INTO Users (UserName, City, JoinDate) VALUES ('Alice', 'Bangalore', '2023-10-01');
INSERT INTO Users (UserName, City, JoinDate) VALUES ('Bob', 'Chennai', '2023-09-15');
INSERT INTO Users (UserName, City, JoinDate) VALUES ('Charlie', 'Mumbai', '2024-01-10');
INSERT INTO Drivers (DriverName, City, JoinDate, Rating) VALUES ('John', 'Bangalore', '2023-01-01', 4.7);
INSERT INTO Drivers (DriverName, City, JoinDate, Rating) VALUES ('David', 'Chennai', '2023-03-12', 3.9);
INSERT INTO Drivers (DriverName, City, JoinDate, Rating) VALUES ('Ravi', 'Mumbai', '2024-02-15', 4.2);
INSERT INTO Rides (UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status) VALUES (1, 1, 'Bangalore', 'Mysore', 600, '2024-12-10', 'Completed');
INSERT INTO Rides (UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status) VALUES (2, 2, 'Chennai', 'Pondicherry', 400, '2024-11-15', 'Cancelled');
INSERT INTO Rides (UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status) VALUES (3, 3, 'Mumbai', 'Pune', 750, '2024-12-01', 'Completed');
INSERT INTO Rides (UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status) VALUES (1, 3, 'Mumbai', 'Bangalore', 1200, '2024-12-18', 'Completed');
INSERT INTO Payments (RideID, Amount, PaymentMethod, PaymentStatus) VALUES (5, 600, 'UPI', 'Success');
INSERT INTO Payments (RideID, Amount, PaymentMethod, PaymentStatus) VALUES (6, 400, 'Cash', 'Failed');
INSERT INTO Payments (RideID, Amount, PaymentMethod, PaymentStatus) VALUES (7, 750, 'Credit Card', 'Success');
INSERT INTO Payments (RideID, Amount, PaymentMethod, PaymentStatus) VALUES (8, 1200, 'UPI', 'Success');
INSERT INTO Feedback (RideID, UserRating, DriverRating, Comments) VALUES (5, 5, 5, 'Smooth ride and polite driver');
INSERT INTO Feedback (RideID, UserRating, DriverRating, Comments) VALUES (6, 2, 3, 'Driver was late');
INSERT INTO Feedback (RideID, UserRating, DriverRating, Comments) VALUES (7, 4, 4, 'Clean car and helpful driver');
INSERT INTO Feedback (RideID, UserRating, DriverRating, Comments) VALUES (8, 5, 4, 'Quick and safe travel');

INSERT INTO Feedback (RideID, UserRating, DriverRating, Comments) VALUES (5, 5, 3, 'Smooth ride and polite driver');
INSERT INTO Feedback (RideID, UserRating, DriverRating, Comments) VALUES (5, 5, 5, 'Smooth ride and polite driver');
INSERT INTO Feedback (RideID, UserRating, DriverRating, Comments) VALUES (5, 5, 4, 'Smooth ride and polite driver');


INSERT INTO Users (UserName, City, JoinDate) VALUES
('Johnny Ayers', 'Lake Crystal', '2024-07-06'),
('Micheal Klein', 'Port Dalton', '2023-11-10'),
('Michelle Taylor', 'Greggstad', '2024-09-29'),
('Dr. Michelle Glover', 'Sashaport', '2024-09-27'),
('Mrs. Abigail Stanley', 'Port Caroline', '2024-01-13'),
('Joanne Zhang', 'New Monicaton', '2023-08-10'),
('Robin Torres', 'Jillianberg', '2024-07-23'),
('David Lynch', 'Adamburgh', '2023-11-01'),
('Kathleen Murphy', 'Lake Jennaburgh', '2024-08-25'),
('Andrea Patrick', 'East Jasmine', '2023-11-18'),
('Melissa Moore', 'South Gregoryberg', '2023-07-21'),
('Jesse Reed', 'Lake Keithberg', '2024-06-12'),
('Douglas Hunt', 'Port Lori', '2023-10-03'),
('Jason Briggs', 'Lake Davidchester', '2024-05-08'),
('Tamara Hernandez', 'Lake Lauraburgh', '2024-07-02'),
('Sean Santiago', 'Lake Wendy', '2024-05-06'),
('Nicholas Ross', 'Lindseyside', '2023-12-07'),
('Nicole Phillips', 'Lake Judyville', '2023-07-28'),
('Danielle Stewart', 'Richardside', '2023-09-26'),
('Mr. Mario Wise', 'New Autumn', '2023-07-24'),
('April Butler', 'Davidmouth', '2023-09-14'),
('Victor Gonzalez', 'Lake Brentrand', '2024-03-09'),
('Tiffany Rios', 'East Nicole', '2023-09-19'),
('Stephanie Lopez', 'Shannaville', '2023-08-25'),
('Kaitlin Evans', 'Lake Julie', '2024-05-13'),
('Laura Munoz', 'East Richard', '2024-02-19'),
('Miss Madison Lopez', 'Martintown', '2024-03-11'),
('Jessica Stewart', 'Port Stacyland', '2023-12-08'),
('Brenda Smith', 'South Melissa', '2023-10-04'),
('Samantha Sutton', 'Phillipsborough', '2024-03-17');

INSERT INTO Drivers (DriverName, City, JoinDate, Rating) VALUES
('Brenda Chavez', 'West Curtisland', '2023-06-19', 4.94),
('Joseph Collins', 'East Kimberlymouth', '2022-11-14', 3.86),
('Rebecca Russell', 'Angelaview', '2024-03-11', 3.45),
('Jennifer Davis', 'Lake Elizabeth', '2023-12-11', 3.76),
('Brianna Edwards', 'North Jacob', '2023-04-22', 4.85),
('Matthew Garcia', 'East Matthew', '2024-04-13', 3.02),
('Miss Julie Fisher', 'Alexisland', '2024-03-06', 4.79),
('Danielle Jenkins', 'Teresafurt', '2023-08-13', 3.6),
('Diana Davis', 'Jasonstad', '2024-06-12', 4.57),
('Heather Rios', 'West Darrellmouth', '2023-07-04', 3.95),
('Colleen Figueroa', 'Port Aprilmouth', '2023-06-27', 3.08),
('Christina Huffman', 'Port Ryanburgh', '2023-11-19', 4.59),
('Edward Black', 'Jenniferville', '2023-09-19', 4.06),
('Anthony Parker', 'North Timothy', '2024-02-18', 4.96),
('Danielle Harrison', 'East Christinefurt', '2023-10-12', 3.62),
('Jeffrey Sparks', 'Port Julie', '2023-09-13', 4.43),
('Dr. Michael Hopkins', 'Stevensmouth', '2023-12-13', 3.14),
('Tina Howard', 'Rodriguezshire', '2023-11-21', 4.04),
('Matthew Terry', 'Lake Matthewberg', '2023-12-28', 4.63),
('Joseph Delgado', 'Port Jon', '2023-04-25', 3.82),
('Caleb Walters', 'South Brendaville', '2023-11-10', 3.68),
('Shawn Munoz', 'South Teresa', '2023-11-26', 4.97),
('Timothy Newton', 'Lake Nicholasville', '2022-09-09', 4.6),
('Misty Mclean', 'South Brenda', '2023-11-16', 4.85),
('Linda Estrada', 'North Zacharyberg', '2022-10-21', 3.31),
('Joanna Chan', 'Dawnville', '2023-06-23', 3.1),
('Justin Johnson', 'Martintown', '2023-05-23', 3.83),
('Derek Miller', 'Carriemouth', '2023-03-28', 4.09),
('Victoria Mendez', 'East Andrewhaven', '2022-08-20', 4.27),
('Jessica Pope', 'Codybury', '2023-07-22', 3.43);

INSERT INTO Rides (UserID, DriverID, StartCity, EndCity, Fare, RideDate, Status) VALUES
(2, 8, 'New Lori', 'North Matthewstad', 94.76, '2023-09-14 17:48:16', 'Completed'),
(16, 17, 'North Dennisfurt', 'South Dawnside', 354.88, '2023-08-04 13:35:38', 'Completed'),
(2, 3, 'North Andreafort', 'West Tammyton', 280.71, '2023-11-01 12:12:29', 'Cancelled'),
(11, 14, 'Mooretown', 'Davidberg', 413.1, '2023-09-04 22:48:17', 'Cancelled'),
(2, 21, 'Lake Barrychester', 'West Diana', 179.56, '2023-12-26 08:55:27', 'Completed'),
(1, 17, 'Lake Tracy', 'Mckinneyborough', 193.18, '2024-04-07 01:53:40', 'Cancelled'),
(12, 7, 'Christineberg', 'West Josephside', 120.6, '2023-08-26 21:36:37', 'Completed'),
(21, 17, 'Dawnchester', 'North Donna', 63.89, '2023-08-15 22:59:36', 'Ongoing'),
(24, 10, 'Davidview', 'Port Sarah', 88.91, '2023-11-01 01:15:09', 'Cancelled'),
(9, 17, 'New Anne', 'East Danielle', 393.85, '2023-08-10 06:34:38', 'Cancelled'),
(24, 9, 'Port Erin', 'Lake Johnland', 138.97, '2024-06-04 02:07:14', 'Ongoing'),
(5, 14, 'Johnsonstad', 'Jorgeport', 455.36, '2024-01-25 23:15:41', 'Completed'),
(26, 17, 'Davidmouth', 'Lake Brittanyport', 466.55, '2023-08-13 07:52:24', 'Completed'),
(1, 14, 'East Jessica', 'East Michael', 115.6, '2023-10-21 10:12:42', 'Completed'),
(25, 13, 'New Kathrynview', 'Port Bonnie', 365.11, '2024-02-25 10:38:35', 'Completed'),
(30, 25, 'Port Robert', 'Wandaland', 80.87, '2024-03-04 00:17:58', 'Completed'),
(1, 26, 'Josephland', 'West Nancy', 143.99, '2024-04-18 06:59:35', 'Cancelled'),
(20, 11, 'South Lori', 'Hendersonfurt', 141.85, '2023-11-19 19:26:08', 'Completed'),
(21, 5, 'Chavezton', 'Katherinemouth', 232.68, '2023-11-13 11:10:33', 'Completed'),
(22, 28, 'East Rebecca', 'North Shannon', 315.88, '2024-06-13 16:27:39', 'Cancelled'),
(25, 14, 'Lake Christopher', 'West Josephside', 83.45, '2023-08-13 12:42:52', 'Ongoing'),
(18, 18, 'South David', 'Matthewberg', 484.96, '2023-09-15 16:45:30', 'Completed'),
(1, 8, 'South Tammyview', 'New Jared', 172.03, '2023-10-04 04:39:41', 'Completed'),
(1, 12, 'East Brandon', 'North James', 157.8, '2024-02-23 12:22:26', 'Ongoing'),
(2, 3, 'North David', 'Vazquezhaven', 362.53, '2023-09-13 03:56:43', 'Completed'),
(25, 15, 'Jonathanmouth', 'West Kelseytown', 391.2, '2023-08-27 02:13:01', 'Completed'),
(5, 26, 'Lake Robert', 'Lake Julia', 155.96, '2023-10-20 15:37:06', 'Completed'),
(15, 24, 'West Jeffreychester', 'East Kyle', 161.6, '2024-06-25 08:47:56', 'Ongoing'),
(20, 9, 'Andrewsport', 'East Josephburgh', 402.69, '2023-07-29 02:19:36', 'Ongoing'),
(28, 19, 'West Alex', 'Port Christopher', 115.46, '2024-01-31 01:10:45', 'Ongoing');

SELECT * FROM Rides

