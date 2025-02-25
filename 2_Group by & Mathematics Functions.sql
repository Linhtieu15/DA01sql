--1. hackerrank-weather-observation-station-3.
/*Query a list of CITY names from STATION for cities that have an even ID number. 
Print the results in any order, but exclude duplicates from the answer.*/
SELECT DISTINCT CITY FROM STATION
WHERE ID%2 =0; 

--2. hackerrank-weather-observation-station-4.
/*Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.*/ 
SELECT 
COUNT(CITY) - COUNT(DISTINCT CITY) AS difference
FROM STATION; 

--3.datalemur-alibaba-compressed-mean.
/* You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables 
which includes information on the count of items in each order (item_count table) and the corresponding number of orders for each item count (order_occurrences table).
items_per_order Table:
Column Name	Type
item_count	integer
order_occurrences	integer */
SELECT ROUND(
CAST (SUM(item_count*order_occurrences)/SUM(order_occurrences) AS DECIMAL)
,1) AS mean
FROM items_per_order;

--4.datalemur-matching-skills.
/*Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job.
You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.
Assumption:
There are no duplicates in the candidates table.
candidates Table:
Column Name	Type
candidate_id	integer
skill	varchar*/  
SELECT DISTINCT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING count(skill) = 3;

--5. datalemur-verage-post-hiatus-1.
/*Given a table of Facebook posts, for each user who posted at least twice in 2021, 
write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. 
Output the user and number of the days between each user's first and last post.
posts Table:
Column Name	Type
user_id	integer
post_id	integer
post_content	text
post_date	timestamp */
SELECT user_id, MAX(Date(post_date)) - MIN (Date(post_date))	AS days_between
FROM posts
WHERE post_date between '2020-12-31' AND '2022-01-01'
GROUP BY user_id
HAVING COUNT(post_id)>= 2 ;

--6. datalemur-cards-issued-difference.
/*Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards were issued each month.
Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest issuance cards and the lowest issuance. 
Arrange the results based on the largest disparity.
monthly_cards_issued Table:
Column Name	Type
card_name	string
issued_amount	integer
issue_month	integer
issue_year	integer*/
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) as difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY MAX(issued_amount) - MIN(issued_amount) DESC;

--7. 
/*CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. Each drug is exclusively manufactured by a single manufacturer.
Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred.
Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. 
Display the results sorted in descending order with the highest losses displayed at the top.

pharmacy_sales Table:
Column Name	Type
product_id	integer
units_sold	integer
total_sales	decimal
cogs	decimal
manufacturer	varchar
drug	varchar
*/
SELECT manufacturer,
  COUNT (drug) AS drug_count,
  ABS(SUM(total_sales - cogs)) as total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY ABS(SUM(total_sales - cogs)) DESC;

--8. leetcode-not-boring-movies.
/*Table: Cinema
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10] */
SELECT * 
FROM Cinema
WHERE id%2 != 0
    AND description <> 'boring'
ORDER BY  rating DESC;

--9.leetcode-number-of-unique-subject.
/*Table: Teacher
+-------------+------+
| Column Name | Type |
+-------------+------+
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |
+-------------+------+
(subject_id, dept_id) is the primary key (combinations of columns with unique values) of this table.
Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id. */
 SELECT teacher_id, 
   COUNT(DISTINCT subject_id) AS cnt
 FROM Teacher
 GROUP BY teacher_id;

--10.leetcode-find-followers-count.
/* Table: Followers
+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
(user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user.
Write a solution that will, for each user, return the number of followers.
Return the result table ordered by user_id in ascending order. */
SELECT user_id, 
    COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id ASC ;

--11. leetcode-classes-more-than-5-students.
/*Table: Courses
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled. */
SELECT class 
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;

