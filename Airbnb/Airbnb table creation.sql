
--You're working as a data analyst for Airbnb. The database contains details of hosts, guests, listings, bookings, and reviews.

CREATE DATABASE Airbnb_Booking_Platform;
USE Airbnb_Booking_Platform;

--Database Schema

--Guests
--Column   Description
--guest_id Unique guest ID
--name     Guest’s full name
--city     City where the guest lives

CREATE TABLE Guests
(
guest_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(50),
city VARCHAR(100)
);

--Hosts
--Column   Description
--host_id  Unique host ID 
--name     Host's name
--rating   Average host rating (nullable)

CREATE TABLE Hosts
(
host_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(100),
rating INT DEFAULT NULL 
);

--Listings
--Column          Description
--listing_id      Unique listing ID
--host_id         Foreign key to Hosts
--title           Listing title
--city            City where the property is listed
--price_per_night Price per night in INR

CREATE TABLE Listings
(
listing_id INT PRIMARY KEY IDENTITY(1,1),
host_id INT REFERENCES Hosts(host_id),
title VARCHAR(100),
city Varchar(100),
price_per_night DECIMAL(10,2)
);

--Bookings
--Column       Description
--booking_id   Unique booking ID
--listing_id   Foreign key to Listings
--guest_id     Foreign key to Guests
--check_in     Check-in date
--check_out    Check-out date
--total_amount Total booking amount in INR

CREATE TABLE Bookings
(
booking_id INT PRIMARY KEY IDENTITY(1,1),
listing_id INT REFERENCES Listings(listing_id),
guest_id INT REFERENCES Guests(guest_id),
check_in DATETIME,
check_out DATETIME,
total_amount DECIMAL(10,2)
);

--Reviews
--Column     Description
--review_id  Unique review ID
--guest_id   Foreign key to Guests
--listing_id Foreign key to Listings
--rating     Integer rating (1–5)
--comment    Review text

CREATE TABLE Reviews
(
review_id INT PRIMARY KEY IDENTITY(1,1),
guest_id INT REFERENCES Guests(guest_id),
listing_id INT REFERENCES Listings(listing_id),
rating INT CHECK (rating IN (1, 2, 3, 4, 5)),
comment VARCHAR(500)
);

SELECT * FROM Guests;
SELECT * FROM Hosts;
SELECT * FROM Listings;
SELECT * FROM Bookings;
SELECT * FROM Reviews;