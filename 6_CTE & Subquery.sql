--1: datalemur-duplicate-job-listings.
/*Assume you're given a table containing job postings from various companies on the LinkedIn platform. 
Write a query to retrieve the count of companies that have posted duplicate job listings.
Definition:
Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
job_listings Table:
Column Name	Type
job_id	integer
company_id	integer
title	string
description	string */ 
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
    SELECT company_id, title, description, COUNT(*) AS count
    FROM job_listings
    GROUP BY company_id, title, description
    HAVING COUNT(*) > 1
) AS duplicates;

--2. datalemur-highest-grossing.
/* Assume you're given a table containing data on Amazon customers and their spending on products in different category
write a query to identify the top two highest-grossing products within each category in the year 2022.
The output should include the category, product, and total spend.
product_spend Table:
Column Name	Type
category	string
product	string
user_id	integer
spend	decimal
transaction_date	timestamp*/ 
WITH product_totals AS (
    SELECT category, product, SUM(spend) AS total_spend
    FROM product_spend
    WHERE EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY category, product
),

ranked_products AS (
    SELECT pt1.category, pt1.product, pt1.total_spend,
     (SELECT COUNT(*) FROM product_totals pt2
        WHERE pt2.category = pt1.category
       AND pt2.total_spend > pt1.total_spend
      ) AS num_higher_products
    FROM product_totals pt1 )

SELECT category, product, total_spend
FROM ranked_products
WHERE num_higher_products < 2
ORDER BY category ASC, total_spend DESC;

--3. datalemur-frequent-callers.
/*UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive support for their health care needs 
– whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, emergency assistance, or member portal services.
Write a query to find how many UHG policy holders made three, or more calls, assuming each call is identified by the case_id column.
callers Table:
Column Name	Type
policy_holder_id	integer
case_id	varchar
call_category	varchar
call_date	timestamp
call_duration_secs	integer */
SELECT COUNT( distinct a.policy_holder_id)
FROM callers a
WHERE (SELECT
  COUNT(case_id) as count_call
  FROM callers  b
  WHERE a.policy_holder_id = b.policy_holder_id
  GROUP BY policy_holder_id) >= 3

--4.datalemur-page-with-no-likes.
/*Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").
Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

pages Table:
Column Name	Type
page_id	integer
page_name	varchar 

page_likes Table:
Column Name	Type
user_id	integer
page_id	integer
liked_date	datetime  */
SELECT page_id 
FROM pages
WHERE page_id NOT IN (SELECT page_id FROM page_likes)

--5.datalemur-user-retention.
/*Assume you're given a table containing information on Facebook user actions. 
Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".
An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month.
user_actions Table:
Column Name	Type
user_id	integer
event_id	integer
event_type	string ("sign-in, "like", "comment")
event_date	datetime */
WITH june_active_user AS (
  SELECT DISTINCT user_id
  FROM user_actions
  WHERE EXTRACT(MONTH FROM event_date) = 6
    AND EXTRACT(YEAR FROM event_date) = 2022
    AND event_type IN ('sign-in', 'like', 'comment')
),
july_active_user AS (
  SELECT DISTINCT user_id
  FROM user_actions
  WHERE EXTRACT(MONTH FROM event_date) = 7
    AND EXTRACT(YEAR FROM event_date) = 2022
    AND event_type IN ('sign-in', 'like', 'comment')
)

SELECT 
  7 AS month, 
  COUNT(DISTINCT a.user_id) AS monthly_active_users
FROM june_active_user a
INNER JOIN july_active_user b 
  ON a.user_id = b.user_id;

--6. leetcode-monthly-transactions.
/* Table: Transactions
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount. */
WITH total_transactions AS (
    SELECT 
        TO_CHAR(trans_date, 'YYYY-MM') AS month,
        COALESCE(country, 'Unknown') AS country,  -- xử lý NULL
        COUNT(*) AS trans_count,
        SUM(amount) AS trans_total_amount
    FROM Transactions
    GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), COALESCE(country, 'Unknown')
),

approved_transactions AS (
    SELECT 
        TO_CHAR(trans_date, 'YYYY-MM') AS month,
        COALESCE(country, 'Unknown') AS country,  
        COUNT(*) AS approved_count,
        SUM(amount) AS approved_total_amount
    FROM Transactions
    WHERE state = 'approved'
    GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), COALESCE(country, 'Unknown')
)

SELECT 
    a.month,
    NULLIF(a.country, 'Unknown') AS country,
    a.trans_count,
    COALESCE(b.approved_count, 0) AS approved_count,
    a.trans_total_amount,
    COALESCE(b.approved_total_amount, 0) AS approved_total_amount
FROM total_transactions a
LEFT JOIN approved_transactions b
  ON a.month = b.month AND a.country = b.country
ORDER BY a.month, a.country;

--7.leetcode-product-sales-analysis.
/*Table: Sales
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Write a solution to select the product id, year, quantity, and price for the first year of every product sold.
Return the resulting table in any order. */
SELECT product_id, year as first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN (
    SELECT product_id, MIN(year) AS first_year
    FROM sales
    GROUP BY product_id
);

--8.leetcode-customers-who-bought-all-products.
/*Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.  product_key is a foreign key (reference column) to Product table.
 
Table: Product
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table. */
SELECT DISTINCT customer_id 
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(DISTINCT product_key) FROM Product)

--9.leetcode-employees-whose-manager-left-the-company.
/*Table: Employees
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| manager_id  | int      |
| salary      | int      |
+-------------+----------+
In SQL, employee_id is the primary key for this table. Some employees do not have a manager (manager_id is null). 
 Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. 
When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.
Return the result table ordered by employee_id. */ 
SELECT employee_id 
FROM Employees
WHERE salary < 30000
AND manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id 

--10. leetcode-primary-department-for-each-employee.
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'
   OR employee_id IN (
       SELECT employee_id
       FROM Employee
       GROUP BY employee_id
       HAVING COUNT(*) = 1
   );

--11.leetcode-movie-rating.
WITH rating_count AS (
    SELECT a.user_id, b.name, COUNT(*) AS num_ratings
    FROM MovieRating a
    JOIN Users b ON a.user_id = b.user_id
    GROUP BY a.user_id, b.name
),
max_user AS (
    SELECT name
    FROM rating_count
    WHERE num_ratings = (SELECT MAX(num_ratings) FROM rating_count)
    ORDER BY name ASC LIMIT 1
),
movie_avg_rating AS (
    SELECT a.movie_id, b.title, AVG(a.rating) AS avg_rating
    FROM MovieRating a
    JOIN Movies b ON a.movie_id = b.movie_id
    WHERE a.created_at >= '2020-02-01' AND a.created_at < '2020-03-01'
    GROUP BY a.movie_id, b.title
),
max_movie AS (
    SELECT title
    FROM movie_avg_rating
    WHERE avg_rating = (SELECT MAX(avg_rating) FROM movie_avg_rating)
    ORDER BY title ASC
    LIMIT 1
)

SELECT result AS results
FROM (
    SELECT name AS result FROM max_user
    UNION ALL
    SELECT title AS result FROM max_movie
) t ;

--12.leetcode-who-has-the-most-friends
/*Table: RequestAccepted
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
Write a solution to find the people who have the most friends and the most friends number. */
SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS all_friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;







