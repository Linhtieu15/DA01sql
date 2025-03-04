--1. hackerrank-more-than-75-marks.
/*Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. 
If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.*/
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT(Name,3), ID ASC

--2. leetcode-fix-names-in-a-table.
/*Table: Users
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
Return the result table ordered by user_id. */
SELECT user_id, 
   concat(upper(LEFT(name,1)),  lower(RIGHT(name,length(name)-1))) AS name
FROM Users 
ORDER BY user_id

--3.datalemur-total-drugs-sales.
/*CVS Health wants to gain a clearer understanding of its pharmacy sales and the performance of various products.
Write a query to calculate the total drug sales for each manufacturer. 
Round the answer to the nearest million and report your results in descending order of total sales. 
In case of any duplicates, sort them alphabetically by the manufacturer name.
Since this data will be displayed on a dashboard viewed by business stakeholders, please format your results as follows: "$36 million". 
pharmacy_sales Table:
Column     	   Type
product_id	  integer
units_sold	  integer
total_sales	  decimal
cogs	        decimal
manufacturer	varchar
drug	        varchar*/
SELECT manufacturer,
  CONCAT('$',ROUND(SUM(total_sales)/1000000,0),' ','million') AS sales_mil
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer ASC

--4. datalemur-avg-review-ratings.
/*Given the reviews table, write a query to retrieve the average star rating for each product, grouped by month. 
  The output should display the month as a numerical value, product ID, and average star rating rounded to two decimal places. 
  Sort the output first by month and then by product ID.
'reviews' Table:
Column Name	  Type
review_id	    integer
user_id	      integer
submit_date	  datetime
product_id	  integer
stars	        integer (1-5) */
SELECT 
  EXTRACT(month FROM submit_date) AS mnth,
  product_id AS product,
  ROUND(AVG(stars),2) AS avg_stars
FROM reviews
GROUP BY EXTRACT(month FROM submit_date), product_id
ORDER BY EXTRACT(month FROM submit_date), product_id

--5.datalemur-teams-power-users. 
/* Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.
Asumption: No two users have sent the same number of messages in August 2022.
'messages' Table:
Column Name	 Type
message_id	 integer
sender_id	   integer
receiver_id	 integer
content	     varchar
sent_date	   datetime */
SELECT sender_id,
  COUNT(message_id)  AS message_count
FROM messages
WHERE EXTRACT(month FROM sent_date) = '8' 
      AND EXTRACT(year FROM sent_date) = '2022'
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC 
LIMIT 2;

--6. leetcode-invalid-tweets.
/*Table: Tweets
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
content consists of characters on an American Keyboard, and no other special characters.
This table contains all the tweets in a social media app.
Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
Return the result table in any order. */
SELECT  tweet_id 
FROM Tweets
WHERE LENGTH(content ) > 15;

--7. leetcode-user-activity-for-the-past-30-days.
