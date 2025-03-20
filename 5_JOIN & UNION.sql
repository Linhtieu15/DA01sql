--1.hackerrank-average-population-of-each-continent
/*Problem statment:Given two tables, City and Country whose description are given below. 
Print the name of all continents (key: Country.Continent) along with the average City population rounded down to nearest integer.
City
+-------------+----------+
| Field       | Type     |
+-------------+----------+
| ID          | int(11)  |
| Name        | char(35) |
| CountryCode | char(3)  |
| District    | char(20) |
| Population  | int(11)  |
+-------------+----------+
Country
+----------------+-------------+
| Field          | Type        |
+----------------+-------------+
| Code           | char(3)     |
| Name           | char(52)    |
| Continent      | char(50)    |
| Region         | char(26)    |
| SurfaceArea    | float(10,2) |
| IndepYear      | smallint(6) |
| Population     | int(11)     |
| LifeExpectancy | float(3,1)  |
| GNP            | float(10,2) |
| GNPOld         | float(10,2) |
| LocalName      | char(45)    |
| GovernmentForm | char(45)    |
| HeadOfState    | char(60)    |
| Capital        | int(11)     |
| Code2          | char(2)     |
+----------------+-------------+
PS #1: City.CountryCode and Country.Code is same key. 
PS #2: Continent without cities should not be included in output. */
SELECT COUNTRY.Continent, 
ROUND((AVG(CITY.Population)),0) AS AVG_POPULATION
FROM COUNTRY INNER JOIN CITY ON COUNTRY.Code = CITY.CountryCode
GROUP BY COUNTRY.Continent
ORDER BY COUNTRY.Continent;

--2.datalemur-signup-confirmation-rate.
/*Problem statement: New TikTok users sign up with their emails. 
They confirmed their signup by replying to the text confirmation to activate their accounts. 
Users may receive multiple text messages for account confirmation until they have confirmed their new account.
A senior analyst is interested to know the activation rate of specified users in the emails table. 
Write a query to find the activation rate. Round the percentage to 2 decimal places.

Definitions:
emails table contain the information of user signup details.
texts table contains the users' activation information.

emails Table:
Column Name	Type
email_id	integer
user_id	integer
signup_date	datetime

texts Table:
Column Name	Type
text_id	integer
email_id	integer
signup_action	varchar

'Confirmed' in signup_action means the user has activated their account and successfully completed the signup process.*/
SELECT 
  ROUND(CAST(COUNT(t.email_id) AS DECIMAL) / COUNT(DISTINCT e.email_id), 2) 
  AS activation_rate
FROM emails AS e
LEFT JOIN texts AS t
ON e.email_id = t.email_id
AND t.signup_action = 'Confirmed';

--3. datalemur-time-spent-snaps.
/*Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.
Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. 
Round the percentage to 2 decimal places in the output.
Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.

activities Table
Column Name	Type
activity_id	integer
user_id	integer
activity_type	string ('send', 'open', 'chat')
time_spent	float
activity_date	datetime

age_breakdown Table
Column Name	Type
user_id	integer
age_bucket	string ('21-25', '26-30', '31-25') */
SELECT age_breakdown.age_bucket,
  ROUND(SUM(CASE WHEN activities.activity_type = 'send' THEN activities.time_spent ELSE 0 END)/
        SUM(CASE WHEN activities.activity_type IN ('open', 'send') THEN activities.time_spent ELSE 0 END)*100.00, 2) 
  AS send_perc,
  
  ROUND(SUM(CASE WHEN activities.activity_type = 'open' THEN activities.time_spent ELSE 0 END)/
        SUM(CASE WHEN activities.activity_type IN ('open','send') THEN activities.time_spent ELSE 0 END)*100.00, 2) 
  AS open_perc
FROM activities 
INNER JOIN age_breakdown  
ON activities.user_id = age_breakdown.user_id
GROUP BY age_breakdown.age_bucket;

--4. datalemur-supercloud-customer.
/*A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.
Write a query that identifies the customer IDs of these Supercloud customers.
customer_contracts Table:
Column Name	Type
customer_id	integer
product_id	integer
amount	integer

products Table:
Column Name	Type
product_id	integer
product_category	string
product_name	string  */
SELECT customer_id
FROM customer_contracts
JOIN products ON customer_contracts.product_id = products.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT products.product_category) 
       = (SELECT COUNT(DISTINCT product_category) FROM products);

--5. leetcode-the-number-of-employees-which-report-to-each-employee.
SELECT e1.employee_id, 
       e1.name, 
       Count(e2.reports_to)  AS reports_count, 
       Round(Avg(e2.age),0) AS average_age 
FROM   employees as e1 
INNER JOIN employees as e2 
ON e1.employee_id = e2.reports_to 
GROUP  BY e1.employee_id, e1.NAME 
ORDER  BY e1.employee_id ASC; 

--6.leetcode-list-the-products-ordered-in-a-period.
/*+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |
+------------------+---------+
product_id is the primary key (column with unique values) for this table.
This table contains data about the company's products.
 
Table: Orders
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| order_date    | date    |
| unit          | int     |
+---------------+---------+
This table may have duplicate rows.
product_id is a foreign key (reference column) to the Products table.
unit is the number of products ordered in order_date.
Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount. */ 
SELECT a.product_name, 
SUM(b.unit) AS  unit
FROM Products AS a JOIN Orders AS b
ON a.product_id = b.product_id
WHERE EXTRACT(month FROM b.order_date) = '02' 
      AND EXTRACT(year FROM b.order_date) = '2020'
GROUP BY a.product_name
HAVING SUM(B.unit) >= 100

--7.leetcode-sql-page-with-no-likes.
SELECT a.page_id
FROM pages as a
LEFT JOIN page_likes as b 
ON a.page_id = b.page_id
WHERE b.liked_date IS NULL
ORDER BY a.page_id ASC;




