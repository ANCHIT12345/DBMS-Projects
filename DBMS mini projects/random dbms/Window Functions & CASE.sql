--SQL Assignment: Window Functions & CASE
--Context:
--You’re a data analyst working at Facebook. The platform tracks user activity such as posts, likes, and comments. Your job is to generate advanced engagement metrics using window functions and CASE statements.

--Database Schema (Same as Previous Context)
--Users
--·         user_id, name, city, join_date

--Posts
--·         post_id, user_id, content, post_date

--Likes
--·         like_id, user_id, post_id, like_date

--Comments
--·         comment_id, user_id, post_id, content, comment_date

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
