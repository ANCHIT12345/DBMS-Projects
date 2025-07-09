USE Facebook_like_Social_Media_Platform;


SELECT * FROM Users;
SELECT * FROM Posts;
SELECT * FROM Likes;
SELECT * FROM Comments;
SELECT * FROM Friendships;

--Assignment Questions by Subquery Type
--🔹 1. Scalar Subqueries
--Find the name of the user who has made the most posts.

SELECT * FROM Users WHERE user_id = (SELECT TOP 1 user_id FROM posts GROUP BY user_id ORDER BY COUNT(*) DESC);

SELECT TOP 1 user_id FROM posts GROUP BY user_id ORDER BY COUNT(*) DESC;

--Show the content of the post with the maximum number of likes.

SELECT * FROM Posts WHERE post_id = (SELECT TOP 1 post_id FROM Likes GROUP BY post_id ORDER BY COUNT(*) DESC);

SELECT COUNT(*), post_id FROM Likes GROUP BY post_id ORDER BY COUNT(*) DESC;

--Display the name of the user who received the most comments on their posts.

--🔹 2. Table Subqueries (IN, EXISTS, NOT IN, NOT EXISTS)
--List users who have never created a post. (Use NOT IN or NOT EXISTS)

INSERT INTO Users (name,city,join_date)
VALUES ('test','test','2025-10-09 11:20:30');

SELECT U.name FROM Users U WHERE NOT EXISTS (SELECT 1 FROM Posts P WHERE P.user_id = U.user_id );

--List all users who have liked at least one post made by users in Delhi. (Use IN with a subquery)

SELECT U.name FROM Users U WHERE NOT EXISTS (SELECT 1 FROM Likes L WHERE L.user_id = U.user_id);

--Find users who are not friends with anyone. (Use anti-join via NOT EXISTS)

SELECT * FROM Users U WHERE NOT EXISTS (SELECT 1 FROM Friendships F WHERE F.user_id_1 = U.user_id OR F.user_id_2 = U.user_id);

--🔹 3. Subqueries in SELECT, WHERE, and FROM
--Show each user along with the total number of likes they received on all their posts. (Use subquery in SELECT)

SELECT U.name,(SELECT COUNT(*) FROM Posts P JOIN Likes L ON P.post_id = L.post_id WHERE P.user_id = U.user_id) AS Total_number_of_likes FROM Users U;

--List posts that received more likes than the average likes per post. (Use subquery in WHERE)

SELECT COUNT(*) FROM Likes GROUP BY post_id;
SELECT * FROM Posts P WHERE EXISTS (SELECT COUNT(*) FROM Likes GROUP BY post_id)
SELECT * FROM Posts P WHERE 
(SELECT COUNT(*) FROM Likes L WHERE P.post_date = L.post_id) > (SELECT AVG(lcs.lc) FROM (SELECT COUNT(*) AS lc FROM Likes GROUP BY post_id) AS lcs);

--Show user name, post count, and average likes per post using a subquery in the FROM clause.

SELECT U.name,s.post_count,s.avg_likes FROM Users U 
JOIN (SELECT P.user_id, COUNT(P.post_id) post_count,ISNULL(AVG(like_counts.like_count),0) avg_likes  FROM Posts P 
LEFT JOIN (SELECT L.post_id, COUNT(*) AS like_count FROM Likes L GROUP BY l.post_id)
AS Like_counts ON like_counts.post_id = P.post_id GROUP BY P.user_id) AS s ON s.user_id = U.user_id;

--🔹 4. Nested Subqueries
--Find the top 3 users who have received the most comments on their posts.

SELECT P.user_id, COUNT(C.comment_id) total_comments FROM Posts P LEFT JOIN Comments C ON P.post_id = C.post_id GROUP BY P.user_id;

SELECT TOP 3 * 
FROM Users U JOIN 
(SELECT P.user_id, COUNT(C.comment_id) total_comments FROM Posts P LEFT JOIN Comments C ON P.post_id = C.post_id GROUP BY P.user_id) 
user_count ON U.user_id = user_count.user_id ORDER BY user_count.total_comments DESC;

--List users who have liked a post that has more than 10 comments.

SELECT C.post_id, COUNT(*) total_comments FROM Comments C GROUP BY C.post_id HAVING COUNT(*) > 4
SELECT * FROM Likes L WHERE L.post_id IN (SELECT C.post_id FROM Comments C GROUP BY C.post_id HAVING COUNT(*) > 4);
SELECT * FROM Users U JOIN Likes L ON U.user_id = L.user_id WHERE L.post_id IN (SELECT C.post_id FROM Comments C GROUP BY C.post_id HAVING COUNT(*)> 4);


--List all posts created by users who joined before the average join date of all users.

SELECT * FROM Posts P WHERE P.user_id IN (SELECT U.user_id FROM Users U WHERE CAST(U.join_date AS FLOAT) < (SELECT AVG(CAST(join_date AS FLOAT)) FROM Users));

--🔹 5. Correlated Subqueries (vs. Independent)
--Display users whose total post count is above the average post count for users in their city.



--Find posts that have more likes than any other post by the same user.



--List users who commented on their own posts.




--SQL Assignment: Window Functions & CASE
--Context:
--You’re a data analyst working at Facebook. The platform tracks user activity such as posts, likes, and comments. Your job is to generate advanced engagement metrics using window functions and CASE statements.

--Assignment Problems
--🔹 Part A: Window Functions
--1. ROW_NUMBER() / RANK() / DENSE_RANK()
--1.      For each user, assign a row number to their posts based on post_date.

--2.      Rank all posts globally by total number of likes in descending order.

--3.      For each user, use DENSE_RANK() to assign a rank to their posts based on like count.

--2. NTILE(n)
--4.      Divide all users into quartiles based on the number of posts they’ve made.

--5.      Assign each post to 5 engagement buckets based on its number of likes.

--3. LEAD() / LAG()
--6.      For each user, list their post and the date of their previous post using LAG().

--7.      Use LEAD() to get the next post's date for each of a user’s posts.

--4. FIRST_VALUE() / LAST_VALUE()
--8.      For each user, find the content of their first post using FIRST_VALUE().

--9.      For each post, show the latest comment (most recent) using LAST_VALUE() over a partition.

--5. SUM() / AVG() OVER (PARTITION BY)
--10.  Show each user’s total number of likes per post, and the average likes per post for that user.

--11.  Display each user’s post with its total likes and how it compares to their average likes per post.

--6. Running Totals & Moving Averages
--12.  For each user, show the running total of likes across their posts (ordered by post_date).

--13.  Compute a 3-post moving average of likes for each user (sliding window).

--🔹 Part B: CASE Statements
--14.  Add a column to categorize posts based on likes:

--if  like_count >= 100 show 'High Engagement'
--if  like_count >= 20 show 'Medium Engagement'
--ELSE 'Low Engagement'

--15.  For each user, show whether they are ‘Active’ (if they posted in the last 30 days) or ‘Inactive’.

--16.  Categorize comments by sentiment based on keywords (e.g., good, bad, poor, excellent).

--17.  Add a CASE column to classify users as:

--·         ‘New’ if joined in the last 90 days

--·         ‘Established’ if joined in the last 1–2 years

--·         ‘Veteran’ if joined more than 2 years ago

--18.  Show user activity type per interaction using:


--if  comment_id IS NOT NULL show 'Commented'
--if  like_id IS NOT NULL show 'Liked'
--if  post_id IS NOT NULL show 'Posted'
--ELSE 'No Activity'
