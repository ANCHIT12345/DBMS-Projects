--SQL Assignment: Subqueries in a Facebook-like Social Media Platform
--Context:
--You are analyzing data for a social media platform like Facebook. The platform has users, their posts, friend connections, likes, and comments. Your task is to explore usage and engagement metrics using SQL subqueries.

CREATE DATABASE Facebook_like_Social_Media_Platform;
USE Facebook_like_Social_Media_Platform;

--Database Schema
--Users
--Column	Description
--user_id	Unique user ID
--name	    Full name
--city	    City of residence
--join_date	Date the user joined

CREATE TABLE Users
(
user_id INT PRIMARY KEY IDENTITY(1,1),
name VARCHAR(50),
city VARCHAR(100),
join_date DATETIME
);

--Posts
--Column	Description
--post_id	Unique post ID
--user_id	Foreign key to Users
--content	Text content of the post
--post_date	Date the post was made

CREATE TABLE Posts
(
post_id INT PRIMARY KEY IDENTITY(1,1),
user_id INT REFERENCES Users(user_id),
content VARCHAR(1000),
post_date DATETIME
);

--Likes
--Column	Description
--like_id	Unique like ID
--user_id	Foreign key to Users (who liked)
--post_id	Foreign key to Posts
--like_date	Date the like was made

CREATE TABLE Likes
(
like_id INT PRIMARY KEY IDENTITY(1,1),
user_id INT REFERENCES Users(user_id),
post_id INT REFERENCES Posts(post_id),
like_date DATETIME
);

--Comments
--Column	   Description
--comment_id   Unique comment ID
--user_id	   Foreign key to Users (who commented)
--post_id	   Foreign key to Posts
--content	   Text of the comment
--comment_date Date of the comment

CREATE TABLE Comments
(
comment_id INT PRIMARY KEY IDENTITY(1,1),
user_id INT REFERENCES Users(user_id),
post_id INT REFERENCES Posts(post_id),
content VARCHAR(500),
comment_data DATETIME
)

--Friendships
--Column	 Description
--user_id_1	 First user in the friendship
--user_id_2	 Second user in the friendship
--since_date Friendship start date

CREATE TABLE Friendships
(
user_id_1 INT,
user_id_2 INT,
since_date DATETIME,
PRIMARY KEY (user_id_1, user_id_2),
FOREIGN KEY(user_id_1) REFERENCES Users(user_id),
FOREIGN KEY(user_id_2) REFERENCES Users(user_id),
CHECK (user_id_1 <> user_id_2)
);