--Window Functions in SQL — OTT Streaming Platform
--Domain Context: OTT Platform (e.g., Netflix)
--A fictional database stores details about users, their subscriptions, and viewing history of various shows and movies.

CREATE DATABASE OTT_Streaming_Platform;
USE OTT_Streaming_Platform;

--1. UserWatchHistory
--WatchID  UserID  ShowName         Genre     WatchDate   WatchTimeMins  RatingGiven
--101	   U1      Stranger Things  Thriller  2023-07-01  50             4.5
--102      U1      The Office       Comedy    2023-07-02  22             4.0
--103      U2      Dark             Sci-Fi    2023-07-01  45             5.0
--104      U2      Friends          Comedy    2023-07-03  25             4.3
--105      U3      Breaking Bad     Thriller  2023-07-01  48             4.8
--106      U3      The Office       Comedy    2023-07-04  21             4.2
--107      U1      Stranger Things  Thriller  2023-07-04  48             5.0

CREATE TABLE UserWatchHistory
(
WatchID INT PRIMARY KEY IDENTITY(1,1),
UserID VARCHAR(100),
ShowName VARCHAR(100),
Genre VARCHAR(100),
WatchDate DATE,
WatchTimeMins INT,
RatingGiven DECIMAL(10,2)
);

DROP TABLE UserWatchHistory

INSERT INTO UserWatchHistory (UserID, ShowName, Genre, WatchDate, WatchTimeMins, RatingGiven) 
VALUES
('U1' , 'Stranger Things', 'Thriller',  '2023-07-01', 50,             4.5),
('U1' , 'The Office'     , 'Comedy'  ,  '2023-07-02', 22,             4.0),
('U2' , 'Dark'           , 'Sci-Fi'  ,  '2023-07-01', 45,             5.0),
('U2' , 'Friends'        , 'Comedy'  ,  '2023-07-03', 25,             4.3),
('U3' , 'Breaking Bad'   , 'Thriller',  '2023-07-01', 48,             4.8),
('U3' , 'The Office'     , 'Comedy'  ,  '2023-07-04', 21,             4.2),
('U1' , 'Stranger Things', 'Thriller',  '2023-07-04', 48,             5.0);

SELECT * FROM UserWatchHistory;

--Assignment Questions
--🔹 Q1: Top 1 Show per User (Use ROW_NUMBER())
--Write a query to find the top 1 highest-rated show each user has watched. If a user has watched a show multiple times, pick the highest RatingGiven.

WITH CTE_RankedShows AS (
SELECT *,ROW_NUMBER() OVER(PARTITION BY  UserID ORDER BY RatingGiven DESC) AS RN FROM UserWatchHistory 
)
SELECT * FROM CTE_RankedShows WHERE RN =1 ORDER BY UserID;

SELECT *,ROW_NUMBER() OVER(PARTITION BY  UserID ORDER BY RatingGiven DESC) FROM UserWatchHistory;

--Expected Columns: UserID, ShowName, RatingGiven

--🔹 Q2: Show Ranking Within Genre (Use RANK())
--Rank shows based on average watch time (AVG(WatchTimeMins)) within each genre. If two shows have the same average, assign the same rank and skip the next.

SELECT Genre, ShowName, AVG(WatchTimeMins) AS AvgWatchTime, RANK() OVER(PARTITION BY Genre ORDER BY AVG(WatchTimeMins) DESC) AS GenreRank FROM UserWatchHistory GROUP BY Genre, ShowName;

--Expected Columns: Genre, ShowName, AvgWatchTime, RankInGenre

--🔹 Q3: Show Popularity Within Genre (Use DENSE_RANK())
--For each genre, assign a popularity rank based on the total watch time across users using DENSE_RANK().

--SELECT Genre, ShowName, SUM(WatchTimeMins) AS TotalWatchTime, 
--DENSE_RANK() OVER(PARTITION BY Genre ORDER BY SUM(WatchTimeMins) DESC) AS PopularityRank FROM UserWatchHistory GROUP BY Genre, ShowName;

SELECT * FROM UserWatchHistory;

SELECT ShowName, Genre, SUM(WatchTimeMins) AS Total_Watch_time FROM UserWatchHistory GROUP BY Genre, ShowName;

WITH CTE_denserank AS (
SELECT ShowName, Genre, SUM(WatchTimeMins) AS Total_Watch_time FROM UserWatchHistory GROUP BY Genre, ShowName
)
SELECT Genre, ShowName, Total_Watch_time, DENSE_RANK() OVER(PARTITION BY Genre ORDER BY Total_watch_time DESC) AS PopularityRank FROM CTE_denserank

--Expected Columns: Genre, ShowName, TotalWatchTime, PopularityRank

--🔹 Q4: Cumulative Watch Time for Each User (Use SUM() OVER)
--For each user, calculate the cumulative watch time ordered by WatchDate.

SELECT UserID, ShowName, WatchDate, WatchTimeMins, SUM(WatchTimeMins) OVER(PARTITION BY UserID ORDER BY WatchDate, WatchID DESC) AS CumulativeTime 
FROM UserWatchHistory;

--Expected Columns: UserID, ShowName, WatchDate, WatchTimeMins, CumulativeTime

--🔹 Q5: Compare Show Rating to Genre Average (Use AVG() OVER)
--For each show watched, compare the rating given to the average rating for that genre.

SELECT UserID, ShowName, Genre, RatingGiven, AVG(RatingGiven) OVER(PARTITION BY Genre) AS GenreAvgRating, RatingGiven - AVG(RatingGiven) OVER(PARTITION BY Genre) AS DiffFromAvg 
FROM UserWatchHistory

--Expected Columns: UserID, ShowName, Genre, RatingGiven, GenreAvgRating, DiffFromAvg

--🔹 Q6: Identify Binge-Watch Pattern (Use ROW_NUMBER())
--Identify users who watched more than one episode of the same show (same ShowName) on different dates.
--Return only the second/latest occurrence using ROW_NUMBER().

SELECT * FROM UserWatchHistory;

SELECT UserID, ShowName, WatchDate, WatchTimeMins, ROW_NUMBER() OVER(PARTITION BY UserID, ShowName ORDER BY WatchDate) AS rownumber FROM UserWatchHistory;

WITH CTE_rownumber AS (
SELECT UserID, ShowName, WatchDate, WatchTimeMins, ROW_NUMBER() OVER(PARTITION BY UserID, ShowName ORDER BY WatchDate) AS rownumber FROM UserWatchHistory
)
SELECT UserID, ShowName, WatchDate, WatchTimeMins FROM CTE_rownumber WHERE rownumber = 2;

--Expected Columns: UserID, ShowName, WatchDate, WatchTimeMins