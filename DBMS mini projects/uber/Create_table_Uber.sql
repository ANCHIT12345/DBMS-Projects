CREATE DATABASE Uber_database;
USE Uber_database;
-- SQL Assignment: Aggregations & Grouping in Uber Ride Data
-- Context:
-- You are a data analyst at Uber, working with a database that tracks riders, drivers, trips, cities, and payments. Your goal is to generate meaningful business reports using aggregate functions and groupings.

-- Cities
-- Column    Description
-- city_id   Unique city ID
-- city_name Name of the city
-- state     State in which city is located

CREATE TABLE Cities 
(
city_id INT IDENTITY(1,1) PRIMARY KEY,
city_name VARCHAR(100),
state VARCHAR(100)
);

--  Riders
-- Column   Description
-- rider_id Unique rider ID
-- name     Rider name
-- city_id  Foreign key to Cities

CREATE TABLE Riders
(
rider_id INT IDENTITY(1,1) PRIMARY KEY ,
name VARCHAR(50),
city_id INT REFERENCES Cities(city_id)
);

-- Database Schema
--  Drivers
-- Column    Description
-- driver_id Unique driver ID
-- name      Driver name
-- city_id   Foreign key to Cities
-- join_date Date when driver joined

CREATE TABLE Drivers
(
driver_id INT IDENTITY(1,1) PRIMARY KEY ,
driver_name VARCHAR(50),
city_id INT REFERENCES Cities(city_id),
join_date DATETIME
);

--  Trips
-- Column      Description
-- trip_id     Unique trip ID
-- driver_id   Foreign key to Drivers
-- rider_id    Foreign key to Riders
-- trip_date   Date of the trip
-- distance_km Distance of the trip in km
-- fare_amount Amount paid for the trip (nullable for free rides)

CREATE TABLE Trips
(
trip_id INT IDENTITY(1,1) PRIMARY KEY ,
driver_id INT REFERENCES Drivers(driver_id),
rider_id INT REFERENCES Riders(rider_id),
trip_date DATETIME,
distance_km DECIMAL(10,2),
fare_amount DECIMAL(10,2)
);



SELECT * FROM Drivers;

SELECT * FROM Riders;

SELECT * FROM Cities;

SELECT * FROM Trips;


DROP TABLE Trips;

DROP TABLE Drivers;

DROP TABLE Riders;

DROP TABLE Cities;

