USE `irctc database`;

-- SQL Assignment: Joins in IRCTC Database
-- Context:
-- You are managing the backend of a simplified IRCTC reservation system. Your database must support customer bookings, train schedules, station information, and ticket status tracking.

-- Table Structures
-- 🧾 Passengers
-- Column        DataType Description 
-- passenger_id  INT (PK) Unique passenger ID
-- name          VARCHAR  Passenger name
-- age           INT      Age of the passenger
-- gender        VARCHAR  Gender
 
 CREATE TABLE Passengers
 (
 passenger_id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(100),
 age INT,
 gender ENUM('Male','Female','Other')
 );
 
 DROP TABLE Passengers;
 
 INSERT INTO Passengers (name, age, gender)
 VALUES ('Amit',30, 'Male'),
 ('Pavan', 28, 'Male'),
 ('Nidhi', 29, 'Female'),
 ('Anushka',32,'Female'),
 ('Alok',23,'Male');
 
 INSERT INTO Passengers (name, age, gender)
 VALUES ('Namita', 33, 'Female'),
 ('Raju', 25, 'Male');
 
-- 🚆 Trains
-- Column         DataType Description
-- train_id       INT (PK) Unique train ID
-- train_name     VARCHAR  Name of the train
-- source_station VARCHAR  Source station code
-- dest_station   VARCHAR  Destination station code

CREATE TABLE Trains
(
train_id INT PRIMARY KEY AUTO_INCREMENT,
train_name VARCHAR(100),
source_station VARCHAR(100) REFERENCES Stations(station_name),
source_station_code VARCHAR(20) REFERENCES Stations(station_code),
dest_station VARCHAR(100) REFERENCES Stations(station_name),
dest_station_code VARCHAR(20) REFERENCES Stations(station_code)
);

DROP TABLE Trains;

INSERT INTO Trains 
(train_name, source_station, source_station_code, dest_station, dest_station_code)
VALUES
('Rajdhani Express', 'New Delhi', 'NDLS', 'Mumbai Central', 'BCT'),
('Shatabdi Express', 'Chennai Central', 'MAS', 'Coimbatore Junction', 'CBE'),
('Duronto Express', 'Howrah Junction', 'HWH', 'Pune Junction', 'PUNE'),
('Garib Rath Express', 'Secunderabad Junction', 'SC', 'Visakhapatnam Junction', 'VSKP'),
('Intercity Express', 'Krantivira Sangolli Rayanna (Bengaluru Station)', 'SBC', 'Mysuru Junction', 'MYS'),
('Jan Shatabdi Express', 'New Delhi', 'NDLS', 'Lucknow Junction', 'LKO'),
('Superfast Express', 'Ahmedabad Junction', 'ADI', 'Jodhpur Junction', 'JU'),
('Humsafar Express', 'Chennai Central', 'MAS', 'Bhubaneswar', 'BBS'),
('Sampark Kranti', 'Secunderabad Junction', 'SC', 'Jabalpur Junction', 'JBP'),
('Double Decker Express', 'Mumbai Central', 'BCT', 'Ahmedabad Junction', 'ADI'),
('Vande Bharat Express', 'Howrah Junction', 'HWH', 'Patna Junction', 'PNBE'),
('Holiday Special', 'Ratlam Junction', 'RTM', 'Jodhpur Junction', 'JU'),
('Garib Rath Special', 'Ranchi Junction', 'RNC', 'Gaya Junction', 'GAYA'),
('Intercity SF', 'Kanpur Central', 'CNB', 'Lucknow Junction', 'LKO'),
('Passenger Special', 'Krantivira Sangolli Rayanna (Bengaluru Station)', 'SBC', 'Mysuru Junction', 'MYS'),
('Express Link', 'New Delhi', 'NDLS', 'Ahmedabad Junction', 'ADI'),
('Dakshin Express', 'Secunderabad Junction', 'SC', 'Chennai Central', 'MAS'),
('Eastern Express', 'Patna Junction', 'PNBE', 'Howrah Junction', 'HWH'),
('Central Mail', 'Mumbai Central', 'BCT', 'Pune Junction', 'PUNE'),
('South Star Express', 'Chennai Central', 'MAS', 'Coimbatore Junction', 'CBE'),
('Western Link', 'Ahmedabad Junction', 'ADI', 'Ratlam Junction', 'RTM'),
('Northern Sprint', 'New Delhi', 'NDLS', 'Lucknow Junction', 'LKO'),
('Coastal Superfast', 'Visakhapatnam Junction', 'VSKP', 'Bhubaneswar', 'BBS'),
('Midland Express', 'Jabalpur Junction', 'JBP', 'Ranchi Junction', 'RNC'),
('Sunrise Express', 'Secunderabad Junction', 'SC', 'Pune Junction', 'PUNE'),
('Peninsula Express', 'Bengaluru Station', 'SBC', 'Chennai Central', 'MAS'),
('City Interlink', 'Kanpur Central', 'CNB', 'Patna Junction', 'PNBE'),
('Mountain Queen', 'Mysuru Junction', 'MYS', 'Jodhpur Junction', 'JU'),
('Desert Rider', 'Ahmedabad Junction', 'ADI', 'Jodhpur Junction', 'JU'),
('Odisha Express', 'Bhubaneswar', 'BBS', 'Howrah Junction', 'HWH'),
('Capital Express', 'New Delhi', 'NDLS', 'Patna Junction', 'PNBE'),
('Southern Mail', 'Chennai Central', 'MAS', 'Bengaluru Station', 'SBC'),
('Bay Coast Special', 'Visakhapatnam Junction', 'VSKP', 'Chennai Central', 'MAS'),
('Cityliner Express', 'Pune Junction', 'PUNE', 'Mumbai Central', 'BCT'),
('Plains Superfast', 'Patna Junction', 'PNBE', 'Gaya Junction', 'GAYA');

-- 🗓️ Bookings
-- Column       DataType Description
-- booking_id   INT (PK) Unique booking ID
-- passenger_id INT (FK) Linked to Passengers
-- train_id     INT (FK) Linked to Trains
-- journey_date DATE     Date of the journey
-- booking_date DATE     Date when ticket was booked

CREATE TABLE Bookings
(
booking_id INT PRIMARY KEY AUTO_INCREMENT,
passenger_id INT REFERENCES Passengers(passenger_id),
train_id INT REFERENCES Train(train_id),
journey_date DATETIME,
booking_date DATETIME
);

DROP TABLE Bookings;

INSERT INTO Bookings (passenger_id, train_id, journey_date, booking_date) VALUES
(3, 1, '2023-04-15', '2023-03-25'),
(2, 4, '2024-09-10', '2024-08-01'),
(1, 2, '2025-02-18', '2025-01-20'),
(5, 3, '2023-11-05', '2023-10-10'),
(4, 5, '2024-07-22', '2024-06-30'),
(2, 1, '2023-06-12', '2023-05-15'),
(3, 3, '2025-05-28', '2025-05-01'),
(1, 4, '2024-01-09', '2023-12-20'),
(5, 2, '2023-08-19', '2023-07-25'),
(4, 5, '2025-10-11', '2025-09-15'),
(2, 2, '2023-03-07', '2023-02-10'),
(3, 1, '2024-04-26', '2024-03-30'),
(5, 4, '2025-06-17', '2025-05-20'),
(1, 5, '2023-12-13', '2023-11-18'),
(4, 3, '2024-08-25', '2024-07-28'),
(2, 5, '2025-03-19', '2025-02-21'),
(3, 2, '2023-05-23', '2023-04-25'),
(5, 1, '2024-02-15', '2024-01-22'),
(1, 3, '2025-11-08', '2025-10-10'),
(4, 4, '2023-09-29', '2023-09-01'),
(2, 3, '2024-05-14', '2024-04-20'),
(3, 5, '2025-01-30', '2025-01-02'),
(5, 2, '2023-07-04', '2023-06-05'),
(1, 1, '2024-11-21', '2024-10-25'),
(4, 2, '2025-04-04', '2025-03-10'),
(2, 4, '2023-10-18', '2023-09-22'),
(3, 1, '2024-12-06', '2024-11-10'),
(5, 5, '2025-08-23', '2025-07-25'),
(1, 2, '2023-02-14', '2023-01-20'),
(4, 3, '2024-03-12', '2024-02-18');

-- 🎟️ Tickets
-- Column     DataType Description
-- ticket_id  INT (PK) Unique ticket ID
-- booking_id INT (FK) Linked to Bookings
-- seat_no    VARCHAR  Seat number
-- status     VARCHAR  Status (Confirmed, Waiting, Cancelled)

CREATE TABLE Tickets
(
ticket_id INT PRIMARY KEY AUTO_INCREMENT,
booking_id INT REFERENCES Bookings(booking_id),
seat_no VARCHAR(50),
status ENUM('Confirmed', 'Waiting', 'Cancelled')
);

DROP TABLE Tickets;

INSERT INTO Tickets (booking_id, seat_no, status) VALUES
(1, 'S12', 'Confirmed'),
(2, 'S5', 'Waiting'),
(3, 'S17', 'Confirmed'),
(4, 'S23', 'Cancelled'),
(5, 'S2', 'Confirmed'),
(6, 'S9', 'Waiting'),
(7, 'S18', 'Confirmed'),
(8, 'S25', 'Confirmed'),
(9, 'S6', 'Cancelled'),
(10, 'S15', 'Confirmed'),
(11, 'S1', 'Waiting'),
(12, 'S28', 'Confirmed'),
(13, 'S19', 'Confirmed'),
(14, 'S4', 'Waiting'),
(15, 'S11', 'Confirmed'),
(16, 'S20', 'Cancelled'),
(17, 'S7', 'Confirmed'),
(18, 'S26', 'Confirmed'),
(19, 'S13', 'Waiting'),
(20, 'S3', 'Confirmed'),
(21, 'S10', 'Confirmed'),
(22, 'S22', 'Cancelled'),
(23, 'S14', 'Confirmed'),
(24, 'S29', 'Waiting'),
(25, 'S8', 'Confirmed'),
(26, 'S21', 'Confirmed'),
(27, 'S27', 'Cancelled'),
(28, 'S16', 'Confirmed'),
(29, 'S24', 'Waiting'),
(30, 'S30', 'Confirmed');

INSERT INTO Tickets (booking_id, seat_no, status) VALUES
(NULL, 'S31', 'Confirmed'),
(NULL, 'S32', 'Waiting'),
(NULL, 'S33', 'Cancelled'),
(NULL, 'S34', 'Confirmed'),
(NULL, 'S35', 'Waiting'),
(NULL, 'S36', 'Confirmed'),
(NULL, 'S37', 'Cancelled'),
(NULL, 'S38', 'Confirmed'),
(NULL, 'S39', 'Waiting'),
(NULL, 'S40', 'Confirmed');

-- 🏙️ Stations
-- Column       DataType     Description
-- station_code VARCHAR (PK) Station code (e.g., NDLS, BCT)
-- station_name VARCHAR      Full name of the station
-- state        VARCHAR      State where station is located

CREATE TABLE Stations 
(
station_code VARCHAR(20) PRIMARY KEY,
station_name VARCHAR(100),
state VARCHAR(100) 
);

DROP TABLE Stations;
INSERT INTO Stations (station_code, station_name, state) VALUES
('NDLS', 'New Delhi', 'Delhi'),
('BCT', 'Mumbai Central', 'Maharashtra'),
('MAS', 'Chennai Central', 'Tamil Nadu'),
('CBE', 'Coimbatore Junction', 'Tamil Nadu'),
('HWH', 'Howrah Junction', 'West Bengal'),
('PUNE', 'Pune Junction', 'Maharashtra'),
('SC', 'Secunderabad Junction', 'Telangana'),
('VSKP', 'Visakhapatnam Junction', 'Andhra Pradesh'),
('SBC', 'Krantivira Sangolli Rayanna (Bengaluru Station)', 'Karnataka'),
('MYS', 'Mysuru Junction', 'Karnataka'),
('LKO', 'Lucknow Junction', 'Uttar Pradesh'),
('CNB', 'Kanpur Central', 'Uttar Pradesh'),
('GAYA', 'Gaya Junction', 'Bihar'),
('PNBE', 'Patna Junction', 'Bihar'),
('BBS', 'Bhubaneswar', 'Odisha'),
('RNC', 'Ranchi Junction', 'Jharkhand'),
('ADI', 'Ahmedabad Junction', 'Gujarat'),
('JBP', 'Jabalpur Junction', 'Madhya Pradesh'),
('JU', 'Jodhpur Junction', 'Rajasthan'),
('RTM', 'Ratlam Junction', 'Madhya Pradesh');

-- Assignment Questions
-- 🔹 Understanding Relationships and Need for Joins
-- 1.      Identify all foreign key relationships in the above schema.
-- ANSWER
-- booking_id INT REFERENCES Bookings(booking_id),
-- passenger_id INT REFERENCES Passengers(passenger_id),
-- train_id INT REFERENCES Train(train_id),


-- 2.      Why is joining tables necessary to generate a complete train reservation report?
-- ANSWER
-- To get and arrange the data from all table in a presentable manner to the user or the system manager so every thing can be managed easily and can be understood as its ment to be without any confusion
-- to clear any confusion.

-- 🔹 INNER JOIN
-- 3.      Retrieve a list of passengers along with their journey date and train name.

SELECT P.passenger_id, B.journey_date, T.train_name FROM Passengers P INNER JOIN Bookings B ON P.passenger_id = B.passenger_id INNER JOIN Trains T ON B.train_id = T.train_id; 

SELECT * FROM Passengers;
SELECT * FROM Trains;
SELECT * FROM Bookings;
SELECT * FROM Tickets;
SELECT * FROM Stations;

-- 4.      Show all bookings with passenger name, train source station, and destination station.

SELECT P.name,  T.source_station,T.dest_station FROM Passengers P INNER JOIN Bookings B ON P.passenger_id = B.passenger_id INNER JOIN Trains T ON B.train_id = T.train_id; 

-- 🔹 LEFT JOIN
-- 5.      Show all trains and any bookings associated with them (include trains with no bookings).

SELECT T.train_id, T.train_name, B.booking_id, B.journey_date FROM Trains T LEFT JOIN Bookings B ON T.train_id = B.train_id;

-- 6.      Display all passengers along with their booking info, even if they haven’t booked yet.

SELECT * FROM Passengers P LEFT JOIN Bookings B ON B.passenger_id = P.passenger_id;

-- 🔹 RIGHT JOIN
-- 7.      List all ticket entries along with passenger name, even if booking record is missing.
-- (May require RIGHT JOIN or swapping LEFT JOIN if DBMS does not support RIGHT JOIN.)

SELECT P.name, B.booking_id, T.* FROM Bookings B RIGHT JOIN Passengers P ON B.passenger_id = P.passenger_id RIGHT JOIN Tickets T On  B.booking_id = T.booking_id ;

-- 🔹 FULL OUTER JOIN
-- 8.      Retrieve a unified view of all trains and bookings, including unmatched records from both.
-- (Use UNION of LEFT and RIGHT JOINs if FULL OUTER JOIN not supported.)

SELECT * FROM Trains T LEFT JOIN Bookings B ON T.train_id = B.train_id UNION SELECT * FROM Trains T RIGHT JOIN Bookings B ON T.train_id = B.train_id;

-- 🔹 CROSS JOIN
-- 9.      Generate all possible passenger-train combinations (for load test or mock simulation).

SELECT * FROM Trains T CROSS JOIN Passengers P;

-- 10.  How many combinations were generated from the above result?
-- ANSWER
-- 105

-- 🔹 Aliasing and Multi-Table Joins
-- 11.  Rewrite Q3 using aliases for tables (e.g., p, b, t).

SELECT P.name pname ,  T.source_station tss,T.dest_station tds FROM Passengers P INNER JOIN Bookings B ON P.passenger_id = B.passenger_id INNER JOIN Trains T ON B.train_id = T.train_id; 

-- 12.  Show booking details (passenger name, train name, journey date, seat number, ticket status) by joining Passengers, Bookings, Trains, and Tickets.

SELECT P.name, T.train_name, B.journey_date, Ti.seat_no, Ti.status 
FROM Bookings B 
RIGHT JOIN Passengers P ON B.passenger_id = P.passenger_id 
RIGHT JOIN Trains T ON B.train_id = T.train_id 
RIGHT JOIN Tickets Ti On  B.booking_id = Ti.booking_id ;

-- 13.  Display a list of passengers who are travelling to stations in 'Maharashtra' (use Trains, Stations, and Passengers).

SELECT P.passenger_id, P.name, S.state `Travelling To` FROM Bookings B 
RIGHT JOIN Trains T On B.train_id = T.train_id
RIGHT JOIN Passengers P ON B.passenger_id = P.passenger_id 
RIGHT JOIN Stations S ON S.station_code = T.dest_station_code
WHERE station_code = 'BCT';











